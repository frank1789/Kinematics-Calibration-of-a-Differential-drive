function [ Vehicle ] = meanradius( Vehicle )
% MEANRADIUS Calculates the average radius between the right and left been 
% pre estimated also by returning the standard deviation
%

%perform mean and deaviation std
radiusmean = mean([Vehicle.wheelLeft;Vehicle.wheelRight]);
radiusstd  = std([Vehicle.wheelLeft;Vehicle.wheelRight]);

fprintf('%f\n', radiusmean);
fprintf('%f\n', radiusstd);

% new mean value of radius
Vehicle.wheelRight = radiusmean;
Vehicle.wheelLeft  = radiusmean;

end
