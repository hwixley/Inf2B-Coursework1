function m = MyMean(x)
[row,col] = size(x);

if (row == 1) || (col == 1)
    m = sum(x)/col;
else
    m = zeros(1,col);
    for i = 1:col    
        m(i) = sum(x(:,i))/row;
    end
end