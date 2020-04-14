function p = gaussianMV(mu, covar, x)
% Evauate a multivariate Gaussian pdf
% Get dimensions of covariance matrix
[d b] = size(covar);

% Check that the covariance matrix is square
if (d ~= b)
error('Covariance matrix should be square');
end

% force MU and X into column vectors
mu = reshape(mu, d, 1);
x = reshape(x, d, 1);

% Evaluate quntity shown in Eq. 10
p = 1/sqrt((2*pi)^d*det(covar)) * ...
exp(-0.5*(x-mu)'*inv(covar)*(x-mu));
end