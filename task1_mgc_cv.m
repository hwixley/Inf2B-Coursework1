%
% Versin 0.9  (HS 06/03/2020)
%
function task1_mgc_cv(X, Y, CovKind, epsilon, Kfolds)
% Input:
%  X : N-by-D matrix of feature vectors (double)
%  Y : N-by-1 label vector (int32)
%  CovKind : scalar (int32)
%  epsilon : scalar (double)
%  Kfolds  : scalar (int32)
%
% Variables to save
%  PMap   : N-by-1 vector of partition numbers (int32)
%  Ms     : C-by-D matrix of mean vectors (double)
%  Covs   : C-by-D-by-D array of covariance matrices (double)
%  CM     : C-by-C confusion matrix (double)

[N, D] = size(X);

% loop to find number of different classes, repr. by maxClass
maxClass = 1;
for a = 1:N
    if Y(a) > maxClass
        maxClass = Y(a);
    end
end

% loop to find number of samples for each class, repr. by classNum
classNum = zeros(maxClass,1);
classInd = zeros(N,maxClass);
for b = 1:maxClass
    classNum(b) = sum(Y == b);
    classInd(:,b) = Y == b;
end

% loop to find mean number of vectors for a given class in a partition
meanFoldVecs = zeros(maxClass,1);
remainders = zeros(maxClass,1);
for c = 1:maxClass
    meanFoldVecs(c) = floor(classNum(c)/Kfolds);
    remainders(c) = rem(classNum(c),Kfolds);
end

%INITIALISATION OF PMap:
currIndex = N.*ones(maxClass,1);
PMap = zeros(N,1);
for d = Kfolds:-1:1
    for e = 1:maxClass
        remE = 0;
        if remainders(e) > 0
            remE = 1;
            remainders(e) = remainders(e) -1;
        end
        numVecs = meanFoldVecs(e) + remE;

        for f = currIndex(e):-1:1
            if classInd(f,e) == 1
                PMap(f) = d;
                numVecs = numVecs -1;
                if numVecs == 0
                    currIndex(e) = f-1;
                    break;
                end
            end
        end
        
    end
end


  save(sprintf('t1_mgc_%dcv_PMap.mat',Kfolds), 'PMap');
  % For each <p> and <CovKind>
  %  save('t1_mgc_<Kfolds>cv<p>_Ms.mat', 'Ms');
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_Covs.mat', 'Covs');
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_CM.mat', 'CM');
  %  save('t1_mgc_<Kfolds>cv<L>_ck<CovKind>_CM.mat', 'CM');
  % NB: replace <Kfolds>, <p>, and <CovKind> properly.

end
