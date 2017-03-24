function [ data ] = file2data ( filename, pattern )
% FILE2DATA that accepts a file name as input and the pattern
% and separating the variables and collects in an output structure
% input first argument: 'filename',
% input second argument: 'pattern',
% return struct "data" containt working variables
% Measure Units
% time  [ms]
% tick  [#]
% psi   [rad]
% x     [cm]
% y     [cm]

% Local variable
input = importdata( filename, pattern );

% Separe variable TIME import as [ms] 'millisecond' return [s] 'second'
data.time = input.data(:, 1) / 1000;

% Separe variable POSE in a struct
data.pose.x = input.data(:, 2);
data.pose.y = input.data(:, 3);
data.pose.psi = anglecorrection(input.data(:, 4));

% Separe COVARIANCE MATRIX
data.covariance = [
    input.data(:, 5),  input.data(:, 6),  input.data(:, 7);...
    input.data(:, 8),  input.data(:, 9),  input.data(:, 10);...
    input.data(:, 11), input.data(:, 12), input.data(:, 13)];

% Store covariance matrix as colunm
data.cov_11 = input.data(:, 5);
data.cov_12 = input.data(:, 6);
data.cov_13 = input.data(:, 7);
data.cov_21 = input.data(:, 8);
data.cov_22 = input.data(:, 9);
data.cov_23 = input.data(:, 10);
data.cov_31 = input.data(:, 11);
data.cov_32 = input.data(:, 12);
data.cov_33 = input.data(:, 13);

% Separe variable TICK
data.tick.Left  = input.data(:, 14);
data.tick.Right = input.data(:, 15);
end % function
