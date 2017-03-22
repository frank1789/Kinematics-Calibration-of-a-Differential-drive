function [ tmp ] = unbiasedestimaton_1n( theta, angle )
% Unbaised estimation of angular velocity w_i and oritantion angle_i
% Pass function the value angular velocity and angle and return a value for
% Phi matrix estimation

% Preallocate local variable
tmp = double.empty;

for i=1:length(theta)-1
    tmp(i) = (theta(i+1) - theta(i)) * cos(angle(i)+(angle(i+1)-angle(i))/2);
end

end % function

