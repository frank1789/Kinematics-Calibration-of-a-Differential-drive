function [CC] = performcovariance( data, vehicleparams, newpose )
%


%%
% Additional Vehicle parameters
res_encoder              = 16384 * 25;  % Encoder resolution (multiplied by gear train ratio)
vehicleParameters.RSd    = 0.5e-3;      % Wheel radius standard deviation
vehicleParameters.bSd    = 0.5e-3;      % Wheelbase standard deviation
vehicleParameters.width  = 0.5;
vehicleParameters.length = 0.7;

% Instance local variable
Rr   = vehicleparams.wheelRight;
Rl   = vehicleparams.wheelLeft;
b    = vehicleparams.track;
n0   = res_encoder;
stdW = vehicleParameters.RSd;
stdb = vehicleParameters.bSd;
vehicleParameters.wheelRadius= Rr;
nl=data.tick.Left;
nr=data.tick.Right;

v = zeros(length(nl),3);
phi = zeros(length(nr),3);

J = zeros(4,3);
Ik = zeros(3,4);

Cx0 = zeros(3,3);
CC = zeros(length(nl)*3,3);

Cw=[stdW^2     0       0        0;
    0       stdW^2    0        0;
    0         0       stdb^2   0;
    0         0       0        0 ];
Sw=sqrt(Cw);

% Plot covariance ellipse + robot
figure
for i=1:1:length(nl)-1

    x0     = v(i,1);
    y0     = v(i,2);
    delta0 = v(i,3);
    
    x= x0 + pi*((nr(i)*Rr+nl(i)*Rl)/n0)*cos(delta0);
    
    y= y0 + pi*((nr(i)*Rr+nl(i)*Rl)/n0)*sin(delta0);
    
    delta= delta0 + 2*pi*((nr(i)*Rr-nl(i)*Rl)/(n0*b));
    
    v(i+1,:) = [x, y, delta];
    
    phi(i,:) = [newpose.x(i), newpose.y(i), newpose.psi(i)];
    
    
    J      = [pi*((nr(i))/n0)*cos(delta0)              , pi*((nr(i))/n0)*sin(delta0)               , 2*pi*((nr(i))/(n0*b));
        pi*((nl(i))/n0)*cos(delta0)              , pi*((nl(i))/n0)*sin(delta0)               , 2*pi*((-nl(i))/(n0*b));
        0                                        , 0                                         , -2*pi*((nr(i)*Rr-nl(i)*Rl)/(n0*b^2));
        pi*((nr(i)*Rr+nl(i)*Rl)/n0)*-sin(delta0) , pi*((nr(i)*Rr+nl(i)*Rl)/n0)*cos(delta0)   , 0];
    
    
    
    
    Int = J'*Sw*Ik' +Ik*Sw*J;
    Cx = Cx0 + J'*Cw*J +Int;
    Cx0=Cx;
    Cw(4,4)=Cx(3,3);
    Sw=sqrt(Cw);
    Ik = Ik+J'*Sw;
    CC(1+3*i:3+3*i,:)=Cx;
    
    
    if(mod(i,80)==0)
        hold on, grid on, axis equal
        P=0.95;
        vehiclePlotDD_simple( v(i,:) , vehicleParameters, [] );
        [w1, w2, ell_angle] = Covariance2EllipseParameters(CC(1+3*i:3+3*i,:), P);
        myEllipse(w1,w2,ell_angle,v(i,1),v(i,2),'b','-');
    end
    
end
end