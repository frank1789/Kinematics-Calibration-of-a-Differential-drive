function [ newpose ] = estimation2newpose( data, vehicleparams )
% ESTIMATION2NEWPOSE calculates the new path merging the data estimated by
% odometry and the camera data

% Encoder resolution (multiplied by gear train ratio)
% res_encoder = 16384 * 25;
% 
% Insatziate local variable
% [ diffleft, diffright ] = tick2differenceTick( data );
% [ coordinateX, coordinateY, vehicleparamsM ] = centimeter2meter ( data, vehicleparams );
% radwheelL = vehicleparamsM.wheelLeft;
% radwheelR = vehicleparamsM.wheelRight;
% track =  vehicleparamsM.track;
% angle = data.pose.psi;
% 
% Initialize array and calc position
% newpose.x(1)   = coordinateX(1); 
% newpose.y(1)   = coordinateY(1); 
% newpose.psi(1) = angle(1);
% 
% Return new position
% for i=1:length(angle)
%     newpose.x(i+1)   = newpose.x(i)   +   pi * (diffright(i) * radwheelR + diffleft(i) * radwheelL) * (cos(newpose.psi(i))/res_encoder);
%     newpose.y(i+1)   = newpose.y(i)   +   pi * (diffright(i) * radwheelR + diffleft(i) * radwheelL) * (sin(newpose.psi(i))/res_encoder);
%     newpose.psi(i+1) = newpose.psi(i) + 2*pi * (diffright(i) * radwheelR - diffleft(i) * radwheelL) / (res_encoder * track);
% end

% Encoder resolution (multiplied by gear train ratio)
res_encoder = 16384 * 25;

% Insatziate local variable from function
[ diffleft, diffright ] = tick2differenceTick( data );
[ vehicleparams ] = meanradius( vehicleparams );
[ coordinateX, coordinateY, vehicleparamsM ] = centimeter2meter ( data, vehicleparams );

% Insatziate local variable
radwheelL = vehicleparamsM.wheelLeft;
radwheelR = vehicleparamsM.wheelRight;
track =  vehicleparamsM.track;
angle = data.pose.psi;

% Initialize array and calc new position
newpose.x(1)   = coordinateX(1); 
newpose.y(1)   = coordinateY(1); 
newpose.psi(1) = angle(1);

% Return new position
for i=1:length(angle)
    newpose.x(i+1)   = newpose.x(i)   +   pi * (diffright(i) * radwheelR + diffleft(i) * radwheelL) * (cos(newpose.psi(i))/res_encoder);
    newpose.y(i+1)   = newpose.y(i)   +   pi * (diffright(i) * radwheelR + diffleft(i) * radwheelL) * (sin(newpose.psi(i))/res_encoder);
    newpose.psi(i+1) = newpose.psi(i) + 2*pi * (diffright(i) * radwheelR - diffleft(i) * radwheelL) / (res_encoder * track);
end

% free memory
clearvars res_encoder radwheelL radwheelR vehicleparamsM angle 
clearvars diffleft diffright coordinateX coordinateY i
end
