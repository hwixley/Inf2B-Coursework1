function pp = MyPostProb(mu,cov,prior,X)

[N,D] = size(X);

[j, k] = size(cov);
% Check that the covariance matrix is the correct dimension
if ((j ~= D) || (k ~= D))
    error('Dimension of covariance matrix and data should match');
end
invcov = inv(cov);
mu = reshape(mu, 1, D); % Ensure that mu is a row vector

X = X - ones(N, 1)*mu;

prod = X*invcov;
prod = prod*X';

pp = -(1/2.*(prod))-(1/2*log(det(cov)))+log(prior);
end