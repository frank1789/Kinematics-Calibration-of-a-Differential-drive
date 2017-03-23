function graph_tick( data, i )
% Plot function pass argument left -> tick left side, y -> tick right side

% Local variable
left  = data.tick.Left;
right = data.tick.Right;

% Block figure
figure();
% axis plot max lenght of vector + 20%
axis([0, max(size(left) * 1.2), -inf, +inf])
hold on;
plot(left);
plot(right);
grid on;
hold off;
str = sprintf('Tick %d', i);
title(str);
legend('tick left', 'tick rigth');

% Export figure
fname = sprintf('tick_dataset_%d', i);
checkfile{i} = ['tick_dataset_%d' num2str(i) '.eps'];
if exist(checkfile{i}, 'file') == 2
    fprintf('File: %s,already exist\n', fname)
else
    print(fname,'-depsc','-tiff','-r0');
end

end