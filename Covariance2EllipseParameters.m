function [ w1, w2 , ell_angle ] = Covariance2EllipseParameters( D, p )
%COVARIANCE2ELLIPSEPARAMETERS Summary of this function goes here
%   Detailed explanation goes here

% A =  D(1,1);
% B =  D(1,2)+D(2,1);
% C = D(2,2);
% 
% k = -2*(log(1-p));
% 
% 
% ell_angle = 0.5*atan2(-2*B,(A-C));
% 
% T = sqrt(A^2+C^2-2*A*C+4*B^2);
% 
% w1 = sqrt(2*k^2/(A+C-T));
% 
% w2 = sqrt(2*k/(A+C+T));

[vectors,value] = eig(D);
k = 2*log(1/(1-p));
w1 = sqrt(k*value(1,1));
w2 = sqrt(k*value(2,2));
ell_angle = atan2(real(vectors(2,1)),real(vectors(1,1)));

end 

