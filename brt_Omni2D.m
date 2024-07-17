clc
clear
%% Grid
grid_min = [-2.5; -2.5]; % Lower corner of computation domain
grid_max = [2.5; 2.5];    % Upper corner of computation domain
N = [101; 101];         % Number of grid points per dimension
g = createGrid(grid_min, grid_max,N);
%% target set
R = 1;
% data0 = shapeCylinder(grid,ignoreDims,center,radius)
data0 = shapeCylinder(g, 3, [1; 1], R);
%% time vector
t0 = 0;
tMax = 1;
dt = 0.1;
tau = t0:dt:tMax;
%% problem parameters
x0=[0 0];
% input bounds
angleRange= 2*pi;
speed = 1;
dRange= 0.0;
% control trying to min or max value function?
uMode = 'min';
dMode = 'max';

%% Pack problem parameters

% Define dynamic system
%obj = Omni2D(x, angleRange, speed, dRange, dims)
sys = Omni2D( x0, angleRange, speed, dRange); %do dStep3 here

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

%[data, tau, extraOuts] = ...
% HJIPDE_solve(data0, tau, schemeData, minWith, extraArgs)
[data, tau2, ~] = ...
  HJIPDE_solve(data0, tau, schemeData, 'minVWithV0', HJIextraArgs);
