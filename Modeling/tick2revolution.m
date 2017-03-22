function [ revol ] = tick2revolution( tick )
% TICK2OMEGA calculates the omega starting from the encoder tics according to equation
% theta(n) = (ptick(n+1) - tick(n)) * (2 * pi / res_encoder)
% omega(n) =  theta(n) / (time(i) - time(i-1))
% res_encoder is a parameters inside the function
% Input argument tick
% Return the angular velocity

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
