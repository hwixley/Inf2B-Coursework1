function pp = MyPostProb(mu,cov,prior,X)

[n,d] = size(X);

[j, k] = size(cov);
% Check that the covariance matrix is the correct dimension
if ((j ~= d) || (k ~=d))
    error('Dimension of covariance matrix and data should match');
end
invcov = inv(cov);
mu = reshape(mu, 1, d); % Ensure that mu is a row vector

X = X - ones(n, 1)*mu;

prod = X*invcov;
prod = prod*X';

pp = -(1/2.*(prod))-(1/2*log(det(cov)))+log(prior);
pp = log(pp);
end