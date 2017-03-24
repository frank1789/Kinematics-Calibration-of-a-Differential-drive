function [y] = linearfun ( pPhi, pP_posediff, pP_c, p_r )
%LINEARFUN  Given the linear relationship y = W * c + r
% where y is measurement data vector
% W is a determenistic regressor = pPhi
% c vector of unknown parameters = pP_c
% r is vector measurement of noise = p_r
% y = pP_posediff

y = (pP_posediff - pPhi * pP_c)*(pP_posediff - pPhi * pP_c).' + p_r;

end



