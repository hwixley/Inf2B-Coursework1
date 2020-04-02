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
PMap = zeros(N,1);
lastClassIndex = ones(maxClass,1);
partitX = zeros(N,D); % Ordered data set X, P=1:C1-C10 -> P=N:C1->C10
pXI = 1;
foldIndexes = zeros(Kfolds,maxClass);%Matrix of fold & class partitX index'

for d = 1:Kfolds-1
    for e = 1:maxClass
        foldIndexes(d,e) = pXI;
        numVecs = meanFoldVecs(e);
        for f = lastClassIndex(e):N
            if classInd(f,e) == 1
                partitX(pXI,:) = X(f,:);
                pXI = pXI + 1;
                
                PMap(f) = d;
                numVecs = numVecs -1;
                if numVecs == 0
                    lastClassIndex(e) = f+1;
                    break
                end
            end
        end
    end
end
for g = 1:maxClass
    foldIndexes(Kfolds,g) = pXI;
    numVecs = meanFoldVecs(g) + remainders(g);
    for h = lastClassIndex(g):N
        if classInd(h,g) == 1
            partitX(pXI,:) = X(f,:);
            pXI = pXI + 1;
            
            PMap(h) = d;
            numVecs = numVecs -1;
            if numVecs == 0
                break
            end
        end
    end
end

foldIndexes
%partitX

  save(sprintf('t1_mgc_%dcv_PMap.mat',Kfolds), 'PMap');

C = maxClass*Kfolds;
Ms = zeros(C,D);
cInd = 1;
for i = 1:Kfolds
    for j = 1:maxClass
        vex = zeros(Kfolds-1,D);
        vexInd = 1;
        
        if i > 1
            for k = 1:(i-1)
                ind = foldIndexes(k,j);
                vex(vexInd,:) = partitX(ind,:);
                vexInd = vexInd + 1;
            end
            if i < Kfolds
                for l = (i+1):Kfolds
                    ind = foldIndexes(l,j);
                    vex(vexInd,:) = partitX(ind,:);
                    vexInd = vexInd + 1;
                end
            end
        else
            for k = 2:Kfolds
                ind = foldIndexes(k,j);
                vex(vexInd,:) = partitX(ind,:);
                vexInd = vexInd + 1;
            end
        end

        Ms(cInd,:) = MyMean(vex);
        save(sprintf('t1_mgc_%dcv%d_Ms.mat',Kfolds,i), 'Ms');
        
        
        cInd = cInd + 1;
    end
end


  % For each <p> and <CovKind>
  %  save('t1_mgc_<Kfolds>cv<p>_Ms.mat', 'Ms');
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_Covs.mat', 'Covs');
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_CM.mat', 'CM');
  %  save('t1_mgc_<Kfolds>cv<L>_ck<CovKind>_CM.mat', 'CM');
  % NB: replace <Kfolds>, <p>, and <CovKind> properly.

end
