function [ error ] = gaerror(inputparams, data)
% OBJFUN calculates error for every configuration of parameters return
% error along the path

% Encoder resolution (multiplied by gear train ratio)
res_encoder = 16384 * 25;

% Initialize local variable
radwheelL = inputparams(1);
radwheelR = inputparams(2);
track     = inputparams(3);
[ diffleft, diffright ] = tick2differenceTick( data );

% Initialize array and calc new position
newpose.x(1)   = data.pose.x(1);
newpose.y(1)   = data.pose.y(1);
newpose.psi(1) = data.pose.psi(1);

% Calculate ododometric recostruction
for i=1:length(data.pose.psi)
    fprintf('\tProgress generation odometric recostruction: %3.2f%%\r', i/length(data.pose.psi)*100)
    newpose.x(i+1)   = newpose.x(i)   +   pi * (diffright(i) * radwheelR + diffleft(i) * radwheelL) * (cos(newpose.psi(i))/res_encoder);
    newpose.y(i+1)   = newpose.y(i)   +   pi * (diffright(i) * radwheelR + diffleft(i) * radwheelL) * (sin(newpose.psi(i))/res_encoder);
    newpose.psi(i+1) = newpose.psi(i) + 2*pi * (diffright(i) * radwheelR - diffleft(i) * radwheelL) / (res_encoder * track);
end
% clear duplicate rows
newpose.x(1)   = [];
newpose.y(1)   = [];
newpose.psi(1) = [];

% Offset performance
dist    = inputparams(5);
alpha   = inputparams(6);
beta    = inputparams(4);  % rotation between camera and robot reference frames

% data.pose.psi = Camera's absolute orientation angle
x_offset = data.pose.x - dist*cos(alpha + data.pose.psi - beta);
y_offset = data.pose.y - dist*sin(alpha + data.pose.psi - beta);
% Robot's absolute orientation angle -> Psi = theta - beta
xhi = data.pose.psi - beta;

% Objective function, adjust newpose to perform difference
X_err     = x_offset - newpose.x.';
Y_err     = y_offset - newpose.y.';
XHI_err = xhi - newpose.psi.';

% total error
error = rms(X_err + Y_err + XHI_err);

end
