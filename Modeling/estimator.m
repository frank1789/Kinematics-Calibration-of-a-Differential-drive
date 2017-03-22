function [ C1, C2 ] = estimator ( Phi_theta, Phi_XY, P_xy, P_angle )
% The C matrix [c11, c12; c21, c22] estimated in this way may not satisfy 
% the physical constraint of c1/c12 = -c21/c22.
% It is worth noticing that it might be possible to include this constraint
% in the estimation proce- dure after c11 and c22 have been obtained,
% leading to an equation corresponding to (1) with only one unknown.
% Being a model with a smaller number of parameters, however, a
% larger reconstruction error might be experienced.
% The reconstruction error over the angle data collected in the P (P_angle)
% trajectories is then mini-mized in a LS sense by estimating the unknown
% parameters c21 and c22 as (2)
% Inputs parameters:
%  - Phi_theta, Phi_XY are result of previous regression matrix
%  - P_xy, P_angle are trajectoris
% Return: estimated C1 and C2

C1 = pinv( Phi_XY ) * P_xy;       %(1)
%C2 = pinv( Phi_theta ) * P_angle; %(2)

end % function