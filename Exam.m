% KINEMATICS CALIBRATION OF A DIFFERENTIAL DRIVE WHEELCHAIR

% Reset workspace and initialize script
close all;
clear;
clc;

% Initialize debug file
if exist('debug.txt', 'file') == 2
    delete('debug.txt');
end
diary debug.txt

% Call function and dataset
addpath (genpath('Modeling/'));
addpath Data FuncNonLinSquare Graphics;

% Preallocate variable
filename  = char.empty;
data      = struct.empty;
theta     = struct.empty;
omega     = struct.empty;
Phi_theta = double.empty;
Phi_XY    = double.empty;
P_xy      = double.empty;
P_angle   = double.empty;
newpose   = struct.empty;

% Pattern for file input
delimiterIn = ' ';

% Load input dataset file
for i = 1:4
    filename{i} = ['new_Camera_Odo_Data_0' num2str(i) '.txt'];
    % Divide input file in local variable
    [ data{i} ] = file2data( filename{i}, delimiterIn );
    fprintf('### Start analysis file: %s ###\n', filename{i});
    
    % Calculate the angular velocity
    [ theta{i}.Left, omega{i}.Left ]   = tick2theta2omega( data{i}.tick.Left, data{i}.time );
    [ theta{i}.Right, omega{i}.Right ] = tick2theta2omega( data{i}.tick.Right, data{i}.time );
    
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

for i = 1:4
   % Calculate camera position
    [ newpose{i} ] = estimation2newpose( data{i}, Vehicle );
%     
%     Printing graphics
%     graph_angle(data{i}.pose.psi, i);
%     graph_tick(data{i}, i);
%     graph_pose(data{i}.pose.x, data{i}.pose.y, i);
%     graphOdometricCamera( data{i}, newpose{i}, i );
end

% 
for i = 1:4
[ CC ]=performcovariance( data{i}, meanradius(estimateVehicleparams( C )), newpose{i} );
 end
diary off