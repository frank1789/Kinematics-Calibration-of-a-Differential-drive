function [ Obj_func ] = objfun(data, parameters)
% OBJFUN calculates error for every configuration of parameters return
% error along the path

% Initializate local variable
Obj_func = double.empty(length(parameters),0);
% Encoder resolution (multiplied by gear train ratio)
res_encoder = 16384 * 25;

for n = 1:length(parameters)
    
    % Initialize local variable
    radwheelL = parameters(n,1);
    radwheelR = parameters(n,2);
    track     = parameters(n,3);
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
    d = parameters(n,5);     
    alpha = parameters(n,6); 
    beta = parameters(n,4);  % rotation between camera and robot reference frames

    % data.pose.psi = Camera's absolute orientation angle
    xcr = data.pose.x - d*cos(alpha + data.pose.psi - beta);
    ycr = data.pose.y - d*sin(alpha + data.pose.psi - beta);
    % Robot's absolute orientation angle -> Psi = theta - beta
    Psi = data.pose.psi - beta; 
    
    % Objective function, adjust newpose to perform difference
    X_err     = xcr - newpose.x.';
    Y_err     = ycr - newpose.y.';
    THETA_err = Psi - newpose.psi.';
    % sum difference
    T = X_err + Y_err + THETA_err;
    Obj_func(n) = rms(T);
    
    fprintf('Progress analisys parameters: %3.2f%%\r', n/length(parameters)*100);
end
end