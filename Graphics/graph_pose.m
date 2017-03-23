function graph_pose( x, y, i )
% Plot function pass argument x -> postion x, y -> position y

figure();
plot(x, y);
grid on;
str = sprintf('Trajectory dataset %d', i);
title(str)
str = sprintf('Odometric Pose %d', i);
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