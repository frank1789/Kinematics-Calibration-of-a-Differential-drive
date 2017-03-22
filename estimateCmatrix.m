function [ C ] = estimateCmatrix( CollectData, i )

star_pt = [1e-6, 1e-6; 1e-6, 1e-6];

if i == 1
    [C2,resnorm2] = lsqnonlin(@(C2) linearfun( CollectData.Path12.Phi_theta, CollectData.Path12.P_angle, C2, 0 ),star_pt(:,2));
    [C1,resnorm1] = lsqnonlin(@(C1) linearfun( CollectData.Path12.Phi_XY, CollectData.Path12.P_xy, C1, 0 ),star_pt(:,1));
    
elseif i == 2
    [C2,resnorm2] = lsqnonlin(@(C2) linearfun( CollectData.Path34.Phi_theta, CollectData.Path34.P_angle, C2, 0 ),star_pt(:,2));
    [C1,resnorm1] = lsqnonlin(@(C1) linearfun( CollectData.Path34.Phi_XY, CollectData.Path34.P_xy, C1, 0 ),star_pt(:,1));
    
else
    [C2,resnorm2] = lsqnonlin(@(C2) linearfun( CollectData.PathAll.Phi_theta, CollectData.PathAll.P_angle, C2, 0 ),star_pt(:,2));
    [C1,resnorm1] = lsqnonlin(@(C1) linearfun( CollectData.PathAll.Phi_XY, CollectData.PathAll.P_xy, C1, 0 ),star_pt(:,1));
    
end

% Return C matrix
C = [C1(1) C1(2); C2(1) C2(2)];

clearvars C1 C2 resnomr1 resnmorm2
end