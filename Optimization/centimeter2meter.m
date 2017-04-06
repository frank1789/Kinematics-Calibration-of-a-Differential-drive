% store position x, y, vehicle parameters form [cm] to [m]
function [ coordinateX, coordinateY, vehicleparamsM ] = centimeter2meter ( data, vehicleparams )
% CENTIMETER2METER convert value from [cm] in [m]
%

% from centimeters [cm] to [m] diviede by factor 100
factor = 100;

% Convert data
coordinateX = data.pose.x / factor;
coordinateY = data.pose.y / factor;

% Convert parameters
vehicleparamsM.wheelLeft  = vehicleparams.wheelLeft / factor;
vehicleparamsM.wheelRight = vehicleparams.wheelRight / factor;
vehicleparamsM.track      = vehicleparams.track / factor;

clearvars factor
end