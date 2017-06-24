% KINEMATICS CALIBRATION OF A DIFFERENTIAL DRIVE WHEELCHAIR

% Reset workspace and initialize script
close all;
clear;
clc;

% Call function and dataset
addpath (genpath('Modeling/'));
addpath Data FuncNonLinSquare Graphics Optimization;

% Preallocate variable
filename  = char.empty;
data      = struct.empty;
theta     = struct.empty;
Phi_theta = double.empty;
Phi_XY    = double.empty;
P_xy      = double.empty;
P_angle   = double.empty;
newpose   = struct.empty;
pose      = double.empty;

% Pattern for file input
delimiterIn = ' ';

% Load input dataset file
for i = 1:4
    filename{i} = ['new_Camera_Odo_Data_0' num2str(i) '.txt'];
    % Divide input file in local variable
    [ data{i} ] = file2data( filename{i}, delimiterIn );
    fprintf('### Start analysis file: %s ###\n', filename{i});

    % Calculate the angular velocity
    [ theta{i}.Left ]   = tick2theta2omega( data{i}.tick.Left, data{i}.time );
    [ theta{i}.Right ] = tick2theta2omega( data{i}.tick.Right, data{i}.time );

    % Find the matrix Phi_theta, angular rotation matrix
    [ P_angle{i} ]   = vehicle_orientations_angle( data{i}.pose.psi );
    [ Phi_theta{i} ] = regressormatrix_rotational( theta{i}.Left, ...
        theta{i}.Right );
    
    % Phi_XY is Vehicle movements respect the absolute coordinates x and y
    [ Phi_XY{i} ] = regressormatrix_displacement ( data{i} );
    % Calculate P trajectory
    [ P_xy{i} ] = vehicle_orientations_xy(data{i}.pose.x, data{i}.pose.y );
    
    fprintf('### finish analisys: %s ###\n', filename{i})
end

% Collect data from all dataset
collPhi_theta = [Phi_theta{1}; Phi_theta{2}; Phi_theta{3}; Phi_theta{4}];
collP_angle   = [P_angle{1}; P_angle{2}; P_angle{3}; P_angle{4}];
collPhi_XY    = [Phi_XY{1}; Phi_XY{2}; Phi_XY{3}; Phi_XY{4}];
collP_xy      = [P_xy{1}; P_xy{2}; P_xy{3};P_xy{4}];

% Estimte C matrix
[ C ] = estimateCmatrix( collPhi_theta, collP_angle, collPhi_XY, collP_xy );

% Estimate Vehicleparameters
[ Vehicle ] = estimateVehicleparams( C );
[ vehicleparams ] = meanradius( Vehicle );

for i = 1:4
    % Calculate camera position
    [ newpose{i} ] = estimation2newpose( data{i}, Vehicle );
    
    % Printing graphics
    graph_angle(data{i}.pose.psi, i);
    graph_tick(data{i}, i);
    graph_pose(data{i}.pose.x, data{i}.pose.y, i);
    graphOdometricCamera( data{i}, newpose{i}, i );
end
pause(2)
close all
pause(2)

%% START OPTIMIZATION GA
% Determinate camera's offset - Optimization
% Set boundary conditions
% 1st parameter [12 <-> 17.6]  =  right radius
% 2nd parameter [12 <-> 17.6]  =  left radius
% 3rd parameter [51 <-> 57]    =  axle track
% 4th parameter [-pi <-> pi]   =  beta
% 5th parameter [5 <-> 30]     =  distance from center
% 6th parameter [-pi <-> pi]  =  alpha
LB = [12   12   51 -pi  5 -pi];     % lower bound
UB = [17.6 17.6 60  pi 30 pi];      % upper bound

% number of variable
nvars = 6;

% Minimizing function using ga
opts = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
parfor i = 1:4
    
    ObjectiveFunction = @(x)gaerror(x, data{i});
    [ parameters{i}, Fval{i},exitFlag{i},Output{i} ] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB,[],opts);
    
    fprintf('\nDataset: %d\n', i);
    fprintf('\tThe number of generations was : %d\n', Output{i}.generations);
    fprintf('\tThe number of function evaluations was : %d\n', Output{i}.funccount);
    fprintf('\tThe best function value found was : %g\n', Fval{i});
end

for i = 1:4

    % Generate plot 
    graphOdometricCam( data{i}, parameters{i},i);
    printGAresult( parameters{i} )
end

% Generate box-plot for optimized parameters 
graphOptimization( parameters )