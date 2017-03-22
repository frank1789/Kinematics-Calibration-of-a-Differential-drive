function [ Phi_theta ] = regressormatrix_rotational( theta_l , theta_r )
% Calculate rotation in absolute RF get in input angular velocity of
% two wheels from in which Phi_theta is the matrix of angular rotations,
% obtained by means of the data acquired by the right and left encoder:
% the reconstruction error over the angle data
% Return vector of rotation

Phi_theta = [sum(theta_r), sum(theta_l)];
end % function
