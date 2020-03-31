function c = MyCov(x)
[row,~] = size(x);

covSum = bsxfun(@minus,x,MyMean(x));
c = covSum'*covSum/row;
end