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
S = MyCov(X);
R = MyCorr(X);

save('t1_S.mat', 'S');
save('t1_R.mat', 'R');
end
