function [ P_angle ] = vehicle_orientations_angle( angle_position )
% The initial and final vehicle orientations, to be obtained by absolute
% measurements using, e.g., a camera or a geometric triangulation with the
% vehicle still at the start and the end of the considered motion
% trajectory.
% Pass position of angle; Return a vector contains the difference

P_angle = angle_position(end) - angle_position(1);
end


