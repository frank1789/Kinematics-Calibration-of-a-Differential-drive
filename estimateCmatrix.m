function [ C ] = estimateCmatrix( collPhi_theta, collP_angle, collPhi_XY, collP_xy )

star_pt = [1e-6, 1e-6; 1e-6, 1e-6];

[C2,resnorm2] = lsqnonlin(@(C2) linearfun( collPhi_theta, collP_angle, C2, 0 ),star_pt(:,2))
[C1,resnorm1] = lsqnonlin(@(C1) linearfun( collPhi_XY, collP_xy, C1, 0 ),star_pt(:,1))
% Return C matrix
C = [C1(1) C1(2); C2(1) C2(2)];

clearvars C1 C2 resnomr1 resnmorm2
end
