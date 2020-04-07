function ll = likelihood(samplesK,cov,mu,x)
[~,D] = size(x);

ll = -(D/2)*log(2*pi) -(1/2).*log(abs(cov));
ll = ll - (1/2).*((x-mu)').*inv(cov).*(x-mu);
a = zeros(0,0);
for i = 1:D
    a = cat(1,a,MyMean(ll([i:D],i)));
end
ll = a';
end