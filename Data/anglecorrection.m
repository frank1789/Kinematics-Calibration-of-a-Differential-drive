function [ angle ] = anglecorrection( angle )
% ANGLECORRECTION removes the values that generate singularity on the
% measurement of the angles for all length of array 

% for i = 2:length(angle)
%     if ((angle(i) - angle(i-1)) < - 0.5 )
%         angle(i) = angle(i-1) + (angle(i) - angle(i-1)) + pi * 2;
%     elseif ((angle(i) - angle(i-1)) > 0.5 )
%         angle(i) = angle(i-1) + (angle(i) - angle(i-1)) - pi * 2;
%     else 
%         angle(i) = angle(i-1) + (angle(i) - angle(i-1));
%     end
% end
% angle = unwrap(wrapTo2Pi(angle));

for i = 2:length(angle)
    if ((angle(i) - angle(i-1)) < - 0.5 )
        angle(i) = angle(i-1) + (angle(i) - angle(i-1)) + pi * 2;
    elseif ((angle(i) - angle(i-1)) > 0.5 )
        angle(i) = angle(i-1) + (angle(i) - angle(i-1)) - pi * 2;
    else 
        angle(i) = angle(i-1) + (angle(i) - angle(i-1));
    end
end

angle = unwrap(wrapTo2Pi(angle));
end