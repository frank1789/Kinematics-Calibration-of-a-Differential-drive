function graph_pose( x, y, i )
% Plot function pass argument x -> postion x, y -> position y

figure();
plot(x, y);
grid on;
axis equal
str = sprintf('Trajectory dataset');
title(str)
str = sprintf('Camera Pose');
legend(str);

% Export figure
fname = sprintf('trajectory_dataset_%d', i);
checkfile{i} = ['trajectory_dataset_' num2str(i) '.eps'];
if exist(checkfile{i}, 'file') == 2
    fprintf('File: %s,already exist\n', fname)
else
    print(fname,'-depsc','-tiff','-r0');
end

end