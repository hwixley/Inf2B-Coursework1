function d = MyDiscriminant(x,probMat)

d = zeros(length(probMat),1);
for i = 1:length(probMat)
    mu = MyMean(x(i,:))
    cov = MyCov(x(i,:))
    
    d(i) = -(1/2).*(x-mu)'.*inv(cov).*(x-mu)-(1/2).*log(abs(cov))+log(probMat(i));
end
end