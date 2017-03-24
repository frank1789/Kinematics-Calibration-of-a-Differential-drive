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
% tick4params = double.empty();
% diff2tick4params = double.empty();
% 
% Multiply the sum between tick for the vehicle params
% store in a tmp varaible
% for n = 1:length(diffleft)
%     tick4params(n) = (diffright(n) * radwheelR) + (diffleft(n) * radwheelL);
% end
% 
% Multiply the difference between tick for the vehicle params
% store in a tmp varaible
% for n = 1:length(diffleft)
%     diff2tick4params(n) = (diffright(n) * radwheelR) - (diffleft(n) * radwheelL);
% end
% 
% Initialize array and calc position
% newpose.x(1)   = coordinateX(1); 
% newpose.y(1)   = coordinateY(1); 
% newpose.psi(1) = angle(1);
% 
% Return new position
% for i=1:length(angle)
%     newpose.x(i+1)   = newpose.x(i)   +   pi * tick4params(i) * (cos(newpose.psi(i))/res_encoder);
%     newpose.y(i+1)   = newpose.y(i)   +   pi * tick4params(i) * (sin(newpose.psi(i))/res_encoder);
%     newpose.psi(i+1) = newpose.psi(i) + 2*pi * diff2tick4params(i) / (res_encoder*track);
%     disp(newpose.psi(i+1))
% end

% Encoder resolution (multiplied by gear train ratio)
res_encoder = 16384 * 25;

% Insatziate local variable
[ diffleft, diffright ] = tick2differenceTick( data );
[ vehicleparams ] = meanradius( vehicleparams );
[ coordinateX, coordinateY, vehicleparamsM ] = centimeter2meter ( data, vehicleparams );
radwheelL = vehicleparamsM.wheelLeft;
radwheelR = vehicleparamsM.wheelRight;
track =  vehicleparamsM.track;
angle = data.pose.psi;
tick4params = double.empty();
diff2tick4params = double.empty();

% Multiply the sum between tick for the vehicle params
% store in a tmp varaible
for n = 1:length(diffleft)
    tick4params(n) = (diffright(n) * radwheelR) + (diffleft(n) * radwheelL);
end

% Multiply the difference between tick for the vehicle params
% store in a tmp varaible
for n = 1:length(diffleft)
    diff2tick4params(n) = (diffright(n) * radwheelR) - (diffleft(n) * radwheelL);
end

% Initialize array and calc position
newpose.x(1)   = coordinateX(1); 
newpose.y(1)   = coordinateY(1); 
newpose.psi(1) = angle(1);

% Return new position
for i=1:length(angle)
    newpose.x(i+1)   = newpose.x(i)   +   pi * tick4params(i) * (cos(newpose.psi(i))/res_encoder);
    newpose.y(i+1)   = newpose.y(i)   +   pi * tick4params(i) * (sin(newpose.psi(i))/res_encoder);
    newpose.psi(i+1) = newpose.psi(i) + 2*pi * diff2tick4params(i) / (res_encoder*track);
end

% free memory
clearvars res_encoder radwheelL radwheelR vehicleparamsM angle tick4params
clearvars diffleft diffright coordinateX coordinateY k n
end
