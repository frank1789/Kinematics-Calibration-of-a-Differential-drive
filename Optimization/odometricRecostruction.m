function [ newpose ] = odometricRecostruction ( data, parameters )
%ODOMETRICRECOSTRUCTION evaluate a recstruction robot position after
% findout offset camera respect center of robot

% Argument input:
%                - data -> position from original dataset
%                - index -> index of best configuration
%                - i -> counter's value actual dataset
% Compute:
%          - difference of tick
%          - set initial position for recostructionn
%          - calc recostruction
% Retrun:
%           - newpose -> struct contain x psoition, y position,
%           orientations

% Initiliazi local variable
res_encoder = 16384 * 25;
[ diffleft, diffright ] = tick2differenceTick( data );

fprintf('right wheel radius:\t%f\n',parameters(1));
fprintf('left wheel radius:\t%f\n',parameters(2));
fprintf('track:\t%f\n',parameters(3));
fprintf('beta:\t%f\n',parameters(4));
fprintf('d:\t%f\n',parameters(5));
fprintf('alpha:\t%f\n',parameters(6));

radwheelR = parameters(1);
radwheelL = parameters(2);
track     = parameters(3);

% Initialize array and calc new position
newpose.x(1)   = data.pose.x(1);
newpose.y(1)   = data.pose.y(1);
newpose.psi(1) = data.pose.psi(1);

% Return new position
for j =1:length(data.pose.psi)
    newpose.x(j+1)   = newpose.x(j)   +   pi * (diffright(j) * radwheelR + diffleft(j) * radwheelL) * (cos(newpose.psi(j))/res_encoder);
    newpose.y(j+1)   = newpose.y(j)   +   pi * (diffright(j) * radwheelR + diffleft(j) * radwheelL) * (sin(newpose.psi(j))/res_encoder);
    newpose.psi(j+1) = newpose.psi(j) + 2*pi * (diffright(j) * radwheelR - diffleft(j) * radwheelL) / (res_encoder * track);
end

end