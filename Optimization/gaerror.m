function [ error ] = gaerror(inputparams, data)
% OBJFUN calculates error for every configuration of parameters return
% error along the path

% Encoder resolution (multiplied by gear train ratio)
res_encoder = 16384 * 25;

% Initialize local variable
[ diffleft, diffright ] = tick2differenceTick( data );

% Initialize array and calc new position
newpose.x(1)   = data.pose.x(1);
newpose.y(1)   = data.pose.y(1);
newpose.psi(1) = data.pose.psi(1);

% Calculate ododometric recostruction
for i=1:length(data.pose.psi)
    newpose.x(i+1)   = newpose.x(i)   +   pi * (diffright(i) * inputparams(2) + diffleft(i) * inputparams(1)) * (cos(newpose.psi(i))/res_encoder);
    newpose.y(i+1)   = newpose.y(i)   +   pi * (diffright(i) * inputparams(2) + diffleft(i) * inputparams(1)) * (sin(newpose.psi(i))/res_encoder);
    newpose.psi(i+1) = newpose.psi(i) + 2*pi * (diffright(i) * inputparams(2) - diffleft(i) * inputparams(1)) / (res_encoder * inputparams(3));
end

% clear duplicate rows
newpose.x(1)   = [];
newpose.y(1)   = [];
newpose.psi(1) = [];

% calc offset
x_offset = data.pose.x - inputparams(5) * cos(inputparams(6) + data.pose.psi - inputparams(4));
y_offset = data.pose.y - inputparams(5) * sin(inputparams(6) + data.pose.psi - inputparams(4));
xhi = data.pose.psi - inputparams(4);

% Objective function, adjust newpose to perform difference
X_err     = x_offset - newpose.x.';
Y_err     = y_offset - newpose.y.';
XHI_err   = xhi - newpose.psi.';

% total error
error = rms(X_err + Y_err + XHI_err);

end
