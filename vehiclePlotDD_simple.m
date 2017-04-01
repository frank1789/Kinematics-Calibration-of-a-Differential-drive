function [ handlePlot ] = vehiclePlotDD_simple( poseXYD , vehicleParameters, options )


if ~isfield( options, 'blurred' )
    options.blurred = 0 ;
end

if ~isfield( options, 'thickness' )
    options.thickness = 0.1 ;
end

if ~isfield( options, 'legendLocation' )
    options.legendLocation = 'SouthEast' ;
end


%create the colors
if options.blurred == 1
    colorBlue = [0.0 0.8 1.0 ] ;
    colorGreen = [0.4 0.8 0.0 ] ;
    colorBlack = [0.7 0.7 0.7 ] ;
    colorMagenta = [1 0 1] ;
else
    colorBlue = [0.0 0.0 1.0 ] ;
    colorGreen = [0.0 0.4 0.0 ] ;
    colorBlack = [0.0 0.0 0.0 ] ;
    colorMagenta = [1 0 1] ;
end


%% DD vehicle
rightWheelPose  = [ 0 ,  vehicleParameters.wheelRadius/4 + vehicleParameters.width/2 , 0 ] ;
leftWheelPose   = [ 0 , -vehicleParameters.wheelRadius/4 - vehicleParameters.width/2 , 0 ] ;
rightWheelTM    =  PoseParameters2TransformatioMatrix(rightWheelPose) ;
leftWheelTM     =  PoseParameters2TransformatioMatrix(leftWheelPose) ;

% vehicle frame
%%
pp = 0.2 ;
ratio = vehicleParameters.length/vehicleParameters.width ;
frame = [
    -vehicleParameters.length/2, vehicleParameters.length/2*(1-pp), vehicleParameters.length/2, vehicleParameters.length/2, vehicleParameters.length/2*(1-pp), -vehicleParameters.length/2,-vehicleParameters.length/2
    -vehicleParameters.width/2, -vehicleParameters.width/2 , -vehicleParameters.width/2*(1-pp*ratio), +vehicleParameters.width/2*(1-pp*ratio), +vehicleParameters.width/2, vehicleParameters.width/2, -vehicleParameters.width/2
    ones(1,7)] ;


%%
% wheel
wheel = [ -vehicleParameters.wheelRadius , vehicleParameters.wheelRadius , vehicleParameters.wheelRadius , -vehicleParameters.wheelRadius, -vehicleParameters.wheelRadius ;
    -vehicleParameters.wheelRadius/4 , -vehicleParameters.wheelRadius/4 , vehicleParameters.wheelRadius/4 , vehicleParameters.wheelRadius/4, -vehicleParameters.wheelRadius/4  ;
    1, 1 , 1 ,1 , 1 ] ;


% for ii = 1:1:index
transformationMatrix = PoseParameters2TransformatioMatrix( poseXYD );

% plot vehicle frame
frameRT = transformationMatrix * frame ;
p1 = plot( frameRT(1,:) , frameRT(2,:) , 'color',colorBlack , 'linewidth',options.thickness ) ;


% plot wheel frame
rigthWheel = transformationMatrix * rightWheelTM * wheel ;
p2 = plot( rigthWheel(1,:) , rigthWheel(2,:) , 'color',colorMagenta , 'linewidth',options.thickness ) ;

% plot wheel frame
leftWheel = transformationMatrix * leftWheelTM * wheel ;
p3 = plot( leftWheel(1,:) , leftWheel(2,:) , 'color',colorGreen , 'linewidth',options.thickness ) ;

end
