function v = MyVar(x)
[row, col] = size(x);
n = row;

if row == 1 || col == 1
    n = numel(x);
end

varSum = x - MyMean(x);
v = sum(varSum.^2)/n;
end