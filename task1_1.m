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
[N, D] = size(X);

covSum = X - mean(X);
S = covSum'*covSum/N;

R = zeros(D,D);
sDevs = sqrt(sum(covSum.^2)/N);

for a = 1:D
    for b = 1:D
        R(a,b) = S(a,b)/(sDevs(a).*sDevs(b));
    end
end

save('t1_S.mat', 'S');
save('t1_R.mat', 'R');
end
