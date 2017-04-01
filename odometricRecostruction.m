function [ newpose ] = odometricRecostruction ( data, index, parameters,i )
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

fprintf('Configuration minimum error: %i on dataset: %i\n',index, i);
fprintf('right wheel radius:\t%f\n',parameters(index,1));
fprintf('left wheel radius:\t%f\n',parameters(index,2));
fprintf('track:\t%f\n',parameters(index,3));
fprintf('beta:\t%f\n',parameters(index,4));
fprintf('d:\t%f\n',parameters(index,5));
fprintf('alpha:\t%f\n',parameters(index,6));

radwheelR = parameters(index,1);
radwheelL = parameters(index,2);
track     = parameters(index,3);

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