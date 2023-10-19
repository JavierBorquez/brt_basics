clc
clear
%% Grid
grid_min = [-4; -1]; % Lower corner of computation domain
grid_max = [4; 4];    % Upper corner of computation domain
N = [31; 31];         % Number of grid points per dimension
%pdDims = 3;               % -- dimension is periodic
g = createGrid(grid_min, grid_max,N);

%% target set
ceiling = shapeRectangleByCorners(g, [-5; 3], [5; 4]);
ground = shapeRectangleByCorners(g, [-5; -1], [5; 0]);
data0 = shapeUnion(ceiling,ground);
% also try shapeRectangleByCorners, shapeSphere, etc.

%% time vector
t0 = 0;
tMax = 2.0;
dt = 0.1;
tau = t0:dt:tMax;

%% problem parameters

x0=[0 0];
% input bounds
grav= 9.8;
k = 12;
uRange= 1;

% control trying to min or max value function?
uMode = 'max';
dMode = 'min';

%% Pack problem parameters

% Define dynamic system
%obj = VertDrone2D(x, grav, k, uRange)
sys = VertDrone2D(x0, grav, k, uRange)

% Put grid and dynamic systems into schemeData
schemeData.grid = g;
schemeData.dynSys = sys;
schemeData.accuracy = 'high'; %set accuracy
schemeData.uMode = uMode;
schemeData.dMode = dMode;

%% Compute value function

%HJIextraArgs.visualize = false;
% HJIextraArgs.visualize = true; %show plot
HJIextraArgs.visualize.valueSet = 1;
HJIextraArgs.visualize.initialValueSet = 1;
HJIextraArgs.visualize.figNum = 1; %set figure number
HJIextraArgs.visualize.deleteLastPlot = true; %delete previous plot as you update

% see a 2D slice
HJIextraArgs.visualize.plotData.plotDims = [1 1]; %plot x, y
HJIextraArgs.visualize.plotData.projpt = []; %project at 
HJIextraArgs.visualize.viewAngle = [0,90]; % view 2D

%[data, tau, extraOuts] = ...
% HJIPDE_solve(data0, tau, schemeData, minWith, extraArgs)
[data, tau2, ~] = ...
  HJIPDE_solve(data0, tau, schemeData, 'minVOverTime', HJIextraArgs);

ylim([-0.5 3.5])
xlim([-4 4])
