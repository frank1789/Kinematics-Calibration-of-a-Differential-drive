function [ v ] = kinematicmodel( nl, nr, n0, b, Rr, Rl, data )
%KINEMATICMODEL Summary of this function goes here
%   Detailed explanation goes here

% Initiliaze local variable
v = double.empty;

% Initialize array and calc new position
x0(1)      = data.pose.x(1);
y0(1)      = data.pose.y(1);
delta0(1)  = data.pose.psi(1);

for i=1:length(data.pose.psi)
    
    % perform odometric calculation
    x0(i+1)     = x0(i) + pi * ((nr(i) * Rr + nl(i) * Rl) / n0) * cos(delta0(i));
    y0(i+1)     = y0(i) + pi * ((nr(i) * Rr + nl(i) * Rl) / n0) * sin(delta0(i));
    delta0(i+1) = delta0(i) + 2 * pi * ((nr(i) * Rr - nl(i) * Rl) / (n0*b));
end
% Return kinematic model

    v = [x0; y0; delta0];


% Free local variable
clearvars x0 x y0 y delta0 delta i

end

