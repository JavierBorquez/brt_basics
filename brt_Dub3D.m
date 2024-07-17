clc
clear
%% Grid
grid_min = [-1;-1;-pi]; % Lower corner of computation domain
grid_max = [1; 1; pi];    % Upper corner of computation domain
N = [51; 51; 41];         % Number of grid points per dimension
pdDims = 3;          % -- dimension is periodic
g = createGrid(grid_min, grid_max, N, pdDims);

%% target set
data0 =shapeCylinder(g, [3], [0.0,0.6,0], .2); %cylinder by creating a circle on xy plane and repeating it on all theta slices 
 
%% obstacle set
obs_1 = shapeRectangleByCorners(g,[-.8,-.6,-inf],[-.4,-.4,inf]);
obs_2 = shapeRectangleByCorners(g,[0.4,-.2,-inf],[0.8,0.0,inf]);
obs = shapeUnion(obs_1,obs_2);
obs_3 = shapeRectangleByCorners(g,[-.2,0.0,-inf],[0.2,0.2,inf]);
obs = shapeUnion(obs,obs_3);

% pass obstacle func
HJIextraArgs.obstacleFunction = obs;

%% time vector
t0 = 0;
tMax = 2.0;
dt = 0.05;
tau = t0:dt:tMax;

%% problem parameters
x0=[0 0 0];
% input bounds
speed = 0.6;
wRange = 1.1;
dRange  = 0; 
% control trying to min or max value function?
% as the target is negative inside, min tries to go into target 
uMode = 'min'; %control tries to get more into target (reach)
dMode = 'max'; %disturbance tries to move away from target
%if additianaly using obstacles they are defined by default as positive inside
%in that case the reach formulation also works as reach-avoid

% for pure reach or pure avoid control dont pass any function to HJIextraArgs.obstacleFunction
% use uMode='min' for reach and uMode='max' for avoid
% make sure dMode is always use the opposite option

%% Pack problem parameters
% Define dynamic system
sys = Dub3D(x0, speed, wRange, dRange);

% Put grid and dynamic systems into schemeData
schemeData.grid = g;
schemeData.dynSys = sys;
schemeData.accuracy = 'high'; %set accuracy
schemeData.uMode = uMode;
schemeData.dMode = dMode;

%% Compute value function

% HJIextraArgs.visualize = true; %show plot
HJIextraArgs.visualize.valueSet = 1;
HJIextraArgs.visualize.initialValueSet = 1;
HJIextraArgs.visualize.figNum = 1; %set figure number
HJIextraArgs.visualize.deleteLastPlot = false; %delete previous plot as you update

% uncomment if you want to see a 2D slice
HJIextraArgs.visualize.plotData.plotDims = [1 1 0]; %plot x, y
HJIextraArgs.visualize.plotData.projpt = [pi/2]; %project at theta = 0
HJIextraArgs.visualize.viewAngle = [0,90]; % view 2D

%[data, tau, extraOuts] = ...
% HJIPDE_solve(data0, tau, schemeData, minWith, extraArgs)
[data, tau2, ~] = ...
  HJIPDE_solve(data0, tau, schemeData, 'minVWithV0', HJIextraArgs);
% derivatives = computeGradients(g, data(:,:,:,end));
% safety_controller =  sys.optCtrl([], [], derivatives, 'min');
% worst_dist =  sys.optDstb([], [], derivatives, 'max');
% tau = tau2;

xlim([-1 1])
ylim([-1 1])
pbaspect([1 1 1])
