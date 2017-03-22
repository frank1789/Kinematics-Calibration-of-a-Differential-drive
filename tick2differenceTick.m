function [ diffleft, diffright ] = tick2differenceTick( data )
% TICK2DIFFERENCETICK perfom difference between two difference tick
% input parameters data 

% Instaziate local variable
left  = data.tick.Left;
right = data.tick.Right;
diffleft = double.empty;
diffright = double.empty;

for z = 2:(length(left))
    diffleft(z) = (left(z) - left(z - 1));
end

for z = 2:(length(right))
    diffright(z) = (right(z) - right(z - 1));
end

% Transpose the result
diffleft  = transpose(diffleft);
diffright = transpose(diffright);

% Free local variable
clearvars left right
end