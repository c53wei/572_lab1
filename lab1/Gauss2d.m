% Gauss2d 2-D Gaussian pdf
%
% This function creates the pdf for a 2D Gaussian
% random variable
%
% INPUTS:
%   x1 - 1xN vector - range of x1 component
%   x2 - 1xM vector - range of x2 component
%   Mu - 2x1 vector - the mean of the random variable
%   Sigma - 2x2 matrix - the covariance matrix of
%           the random variable
%
% OUTPUT:
%   Y - NxM matrix - the pdf for the range of x1, x2
%
% USAGE (Example):
%   Y = Gauss2d([-3:0.1:3],[0:0.1:6],[0 3]',[1 1; 1 4])

function Y = Gauss2d(x, Mu, Sigma)
   Y = zeros(1, size(x, 2));
   for i=1:size(x, 2)
       v = x(:, i);
       Y(i) = exp(-0.5*(v - Mu)'*inv(Sigma)*(v - Mu))/(2*pi*sqrt(det(Sigma)));
   end
end