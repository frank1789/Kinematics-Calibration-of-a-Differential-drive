function [ Phi_XY ] = regressormatrix_displacement ( data )
% Calculate displacement in absolute RF get in input revolution from
% encoder of two wheels and postion angle, return (2,2) matrix of
% displacement

% Vehicle movements respect the absolute coordinates x and y in the (2,2)
% regressor matrix. To compute an unbais omega_i ed is needed.
% One such estimate can be obtained from equation odometry of a vehicle is
% usually implemented by discrete-time integration
% in this way, however, a biased error in the estimation of the first two
% elements of   is propagated to the estimation of the remaining elements.

% Preallocate local variable
% tickleft  = data.tick.Left;
% tickright = data.tick.Right;
% angle     = data.pose.psi;

% Perform calculus of revolution of wheel
% revoright = tick2revolution( tickright );
% revoleft  = tick2revolution( tickleft );

% Perform the unbiased estimation
% Phi_XY_11 = sum(unbiasedestimaton_1n(revoright, angle));
% Phi_XY_12 = sum(unbiasedestimaton_1n(revoleft, angle));
% Phi_XY_21 = sum(unbiasedestimaton_2n(revoright, angle));
% Phi_XY_22 = sum(unbiasedestimaton_2n(revoleft, angle));

% Return matrix assembled 
% Phi_XY = [Phi_XY_11, Phi_XY_12; Phi_XY_21, Phi_XY_22];

tickleft  = data.tick.Left;
tickright = data.tick.Right;
angle     = data.pose.psi;

revoright = tick2revolution( tickright );
revoleft  = tick2revolution( tickleft );

Phi_XY_11 = sum(unbiasedestimaton_1n(revoright, angle));
Phi_XY_12 = sum(unbiasedestimaton_1n(revoleft, angle));
Phi_XY_21 = sum(unbiasedestimaton_2n(revoright, angle));
Phi_XY_22 = sum(unbiasedestimaton_2n(revoleft, angle));

Phi_XY = [Phi_XY_11, Phi_XY_12; Phi_XY_21, Phi_XY_22];

end  % function
