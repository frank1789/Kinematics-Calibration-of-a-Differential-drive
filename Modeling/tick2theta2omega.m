function [ theta, omega ] = tick2theta2omega( tick, time )
% TICK2THETA2OMEGA calculates theta and omega starting from the encoder 
% tics according to equation.

% perform the differecnce between two ticks and mulitpy by encoder
% resolution
% theta(n) = (ptick(n+1) - tick(n)) * (2 * pi / res_encoder)
% return value theta(n)
  
% Return  angluar velocity [rad/s]
% omega(n) =  theta(n) / (time(i) - time(i-1))

% Preallocate local variable
omega = double.empty;
theta = double.empty;

% Encoder resolution (multiplied by gear train ratio)
res_encoder = 16384 * 25;
DistancePerCount = (2 * pi) / res_encoder;

for n = 2:(length(tick))
    theta(n) = ((tick(n) - tick(n - 1)) * DistancePerCount);
end

% Angular speed [rad/s]
for n = 2:(length(tick))
    omega(n) = theta(n - 1) / (time(n) - time(n - 1));
end

end % function
