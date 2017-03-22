function graph_angle( angle, i )
% Plot function pass argument angle -> orientation

figure();
axis([0, max(size(angle) * 1.2), -inf, +inf])
plot(angle);
grid on;
str = sprintf('Odometric orientation %d', i);
title(str)
str = sprintf('Theta %d', i);
legend(str);
fname = sprintf('angle_dataset_%d', i);
checkfile{i} = ['angle_dataset_' num2str(i) '.eps'];
% Export figure
if exist(checkfile{i}, 'file') == 2
    fprintf('File: %s,already exist\n', fname)
else
    print(fname,'-depsc','-tiff','-r0');
end

end