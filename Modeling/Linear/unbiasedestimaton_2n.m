function [ tmp ] = unbiasedestimaton_2n( theta, angle )
% Unbaised estimate of theta_i
% Pass function the value angular velocity and angle and return a value for
% Phi matrix estimation
% 
% Preallocate local variable
tmp = double.empty;

for n = 2:(length(theta))
    tmp(n) = (theta(n) - theta(n - 1)) * sin(angle(n) + (angle(n) - angle(n - 1)) / 2);
end

end % function