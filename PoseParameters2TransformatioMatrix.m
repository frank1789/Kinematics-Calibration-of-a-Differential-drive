function [ R] = PoseParameters2TransformatioMatrix( v )
%POSEPARAMETERS2TRANSFORMATIOMATRIX Summary of this function goes here
%   Detailed explanation goes here

R = [cos(v(3)) -sin(v(3))  v(1);
     sin(v(3))  cos(v(3))  v(2);
     0            0         1    ];


end

