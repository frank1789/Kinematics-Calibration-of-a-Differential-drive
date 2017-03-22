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

Vehicle.wheelLeft  = C(1,1)*2;
Vehicle.wheelRight = C(1,2)*2;
wheelLeft4track  = 2*C(1,1)/C(2,1);
wheelRight4track = -2*C(1,2)/C(2,2);
Vehicle.track   = (wheelLeft4track + wheelRight4track) / 2;

% Free local variable
clearvars wheelLeft4track wheelRight4track
end