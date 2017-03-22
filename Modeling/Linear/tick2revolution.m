function [ revol ] = tick2revolution( tick )
% TICK2REVOLUTION calculates the revolution starting from the encoder tics
% according to equation theta(n) = tick(n)) * (2 * pi / res_encoder)

% Preallocate local variable
revol = double.empty;

% Encoder resolution (multiplied by gear train ratio)
res_encoder = 16384 * 25;
DistancePerCount = (2 * pi) / res_encoder;

% Angular speed [rad/s]
for n = 1:(length(tick))
    revol(n) = (tick(n)  * DistancePerCount);
end

end % function
