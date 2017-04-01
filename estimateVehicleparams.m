function [ Vehicle ] = estimateVehicleparams( C )
% ESTIMATEVEHICLEPARMAS calculates vehicle parameters from the matrix C
%
%
% Multiply the first element (1st colunm) of matrix C by 2 to obtain
% left radiaus
% Vehicle.wheelLeft  = C(1,1)*2;
% Multiply the second element (2nd colum) of matrix C by 2 to obtain right
%  radiaus
% Vehicle.wheelRight = C(1,2)*2;
%
%Perform the estimation with second element of 2nd row to obtain track of vehicle
%     wheelLeft4track  = 2*C(1,1)/C(2,1);
%     wheelRight4track = -2*C(1,2)/C(2,2);
%     Vehicle.track   = (wheelLeft4track + wheelRight4track) / 2;

Vehicle.wheelLeft  = C(1,1) * 2;
Vehicle.wheelRight = C(1,2) * 2;

wheelLeft4track    = Vehicle.wheelLeft  / C(2,1);
wheelRight4track   =-Vehicle.wheelRight / C(2,2);
Vehicle.track      = (wheelLeft4track + wheelRight4track) / 2;

% Print output
fprintf('The estimated values of the vehicle are:\n')
fprintf('\tRadius of left wheel:\t%f\n', Vehicle.wheelLeft)
fprintf('\tRadius of right wheel:\t%f\n', Vehicle.wheelRight )
fprintf('\tThe track is equal:\t%f\n', Vehicle.track)

% Free local variable
clearvars wheelLeft4track wheelRight4track
end