%
% Versin 0.9  (HS 06/03/2020)
%
function task1_3(Cov)
% Input:
%  Cov : D-by-D covariance matrix (double)
% Variales to save:
%  EVecs : D-by-D matrix of column vectors of eigen vectors (double)  
%  EVals : D-by-1 vector of eigen values (double)  
%  Cumvar : D-by-1 vector of cumulative variance (double)  
%  MinDims : 4-by-1 vector (int32)
[D, ~] = size(Cov);

[vecs,vals] = eig(Cov);
EVecs = zeros(D,D);
EVals = zeros(D,1);

for k = 1:D
    max = 0;
    maxindex = 0;
    for i = 1:D
        if vals(i,i) > max
            max = vals(i,i);
            maxindex = i;
        end  
    end
    EVals(k) = max;
    vectorK = vecs(:,maxindex);
    if vectorK(1) < 0
        vectorK = vectorK*-1;
    end
    EVecs(:,k) = vectorK;
    vals(maxindex,maxindex) = 0;
end

Cumvar = zeros(D,1);
for h = 1:D
    eigVals = zeros(h,1);

    for g = 1:h
        eigVals(g) = EVals(g);
    end
    Cumvar(h) = MyVar(eigVals);
    %Cumvar(h) = var(eigVals);
end

MinDims = zeros(4,1);
percent = [0.7, 0.8, 0.9, 0.95];
for f = 1:4
    for j = 1:D
        if Cumvar(j)/Cumvar(D) >= percent(f) && MinDims(f) == 0
            MinDims(f) = j;
        end
    end
end
        

  save('t1_EVecs.mat', 'EVecs');
  save('t1_EVals.mat', 'EVals');
  save('t1_Cumvar.mat', 'Cumvar');
  save('t1_MinDims.mat', 'MinDims');
end
