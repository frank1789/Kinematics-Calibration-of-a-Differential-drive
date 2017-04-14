function graphOdometricCamera( data, newpose, i )
% Plot function pass argument x -> postion x, y -> position y

% Instance local variable
odometricX = data.pose.x;
odometricY = data.pose.y;
cameraX = newpose.x;
cameraY = newpose.y;
odostr = sprintf('Odometric Pose');
camstr = sprintf('Camera Pose');

figure();
hold on
grid on
axis equal
plot(odometricX, odometricY);
plot(cameraX, cameraY, 'r');
legend(camstr, odostr);
xlabel('[cm]')
ylabel('[cm]')
hold off
str = sprintf('Trajectory dataset %d', i);
title(str)

% Export figure
fname = sprintf('odometric_%d', i);
checkfile{i} = ['odometric_' num2str(i) '.eps'];
if exist(checkfile{i}, 'file') == 2
    fprintf('File: %s,already exist\n', fname)
else
    print(fname,'-depsc','-tiff','-r0');
end

% Free local variable
clearvars odometricX odometricY cameraX cameraY odostr camstr str fname
pause(1);

end