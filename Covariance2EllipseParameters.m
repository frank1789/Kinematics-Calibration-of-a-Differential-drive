function [w1, w2, ell_angle] = Covariance2EllipseParameters(CovarianceMatrix, Pr)

K_square = -2*log( 1 - Pr );  % log = ln -> (logaritmo naturale)

[ eig_vectors, eig_values ] = eig( CovarianceMatrix );

% Get the largest eigenvalue
max_evl = max(max(eig_values));

% Get the index of the largest eigenvector
[max_evector_idx, r] = find(eig_values == max_evl);
max_evc = eig_vectors(:,max_evector_idx);  % [2X1]

% Get the smallest eigenvector and eigenvalue
if(max_evector_idx == 1)
    min_evl = max(eig_values(:,2));
    min_evc = eig_vectors(:,2);
else
    min_evl = max(eig_values(:,1));
    min_evc = eig_vectors(:,1);
end


w1 = sqrt( K_square * max_evl );
w2 = sqrt( K_square * min_evl );
ell_angle = atan2( max_evc(2), max_evc(1) );

% This angle is between -pi and pi.
% Let's shift it such that the angle is between 0 and 2pi
if(ell_angle < 0)
    ell_angle = ell_angle + 2*pi;
end

end