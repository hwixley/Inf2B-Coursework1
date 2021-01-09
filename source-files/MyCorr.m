function c = MyCorr(x)
[~,col] = size(x);

c = zeros(col,col);
stdDevs = MyStd(x);
covs = MyCov(x); 

for a = 1:col
    for b = 1:col
        c(a,b) = covs(a,b)/(stdDevs(a).*stdDevs(b));
    end
end
