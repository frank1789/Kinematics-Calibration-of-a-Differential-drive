function [ P_xy ] = vehicle_orientations_xy( x_position, y_position )
% Vector of measurements, to be obtained by absolute
% measurements using, e.g., a camera or a geometric triangulation with the
% vehicle still at the start and the end of the considered motion
% trajectory.
% Pass position x and y; Return a vector contains the difference

P_x = x_position(end) - x_position(1);
P_y = y_position(end) - y_position(1);
P_xy = [P_x; P_y];

end
