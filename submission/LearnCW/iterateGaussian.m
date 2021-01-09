function Y = iterateGaussian(mu, cov, X)
[N,D] = size(X);
Y = zeros(N,1);

for i = 1:N
    Y(i) = log(gaussianMV(mu,cov,X(i,:)));
end
end