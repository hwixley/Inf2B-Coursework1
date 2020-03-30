%
% Versin 0.9  (HS 06/03/2020)
%
function task1_1(X, Y)
% Input:
%  X : N-by-D data matrix (double)
%  Y : N-by-1 label vector (int32)
% Variables to save
%  S : D-by-D covariance matrix (double) to save as 't1_S.mat'
%  R : D-by-D correlation matrix (double) to save as 't1_R.mat'
[rNum, cNum] = size(X);

covSum = X - mean(X);
S = covSum'*covSum/rNum;

R = zeros(cNum,cNum);
sDevs = sqrt(sum(covSum.^2)/rNum);

for a = 1:cNum
    for b = 1:cNum
        R(a,b) = S(a,b)/(sDevs(a).*sDevs(b));
    end
end

save('t1_S.mat', 'S');
save('t1_R.mat', 'R');
end
