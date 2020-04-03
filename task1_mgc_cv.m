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

  save(sprintf('t1_mgc_%dcv_PMap.mat',Kfolds), 'PMap');
  % PMap successfully initialised and saved

% INITIALISATION OF Ms AND Covs:
C = maxClass;
regularize = diag(epsilon.*ones(1,D)); % regularisation diagonal matrix
MsALL = zeros(maxClass*Kfolds,D);
CovsALL = zeros(maxClass*Kfolds,D,D);

for i = 1:Kfolds
    Ms = zeros(C,D);
    Covs = zeros(C,D,D);
    covSharedSum = 0;
    
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

        Ms(j,:) = MyMean(vex);
        MsALL(j+(maxClass*(i-1)),:) = MyMean(vex);
        % Ms for fold i, class j, successfully initialised and saved
        
        cov = regularize + MyCov(vex);
        if CovKind == 1
            Covs(j,:,:) = cov;
            CovsALL(j+(maxClass*(i-1)),:,:) = cov;
        elseif CovKind == 2
            Covs(j,:,:) = diag(diag(cov));
            CovsALL(j+(maxClass*(i-1)),:,:) = cov;
        else
            covSharedSum = covSharedSum + MyCov(vex);
        end
    end
    
    if CovKind == 3
        cov = regularize + (covSharedSum/maxClass);
        for k = 1:maxClass
            Covs(k,:,:) = cov;
            CovsALL(j+(maxClass*(i-1)),:,:) = cov;
        end
    end
        
    save(sprintf('t1_mgc_%dcv%d_ck%d_Covs.mat',Kfolds,i,CovKind), 'Covs');
    save(sprintf('t1_mgc_%dcv%d_Ms.mat',Kfolds,i), 'Ms');
end

% CALCULATE CONFUSION MATRIX FOR EACH PARTITION P:
prior = sum(classInd)./sum(sum(classInd));
CM = zeros(maxClass,maxClass);
labelSum = 0;
CM_final = CM;

for q = 1:Kfolds
    if q < Kfolds
        rowNum = foldIndexes(q+1,1) - foldIndexes(q,1);
        startI = foldIndexes(q,1);
        endI = foldIndexes(q+1,1)-1;
    else 
        rowNum = N - foldIndexes(q,1) + 1;
        startI = foldIndexes(q,1);
        endI = N;
    end
    test_prob = zeros(rowNum,maxClass);
    partition = partitX((startI:endI),:);
    
    test_labels = zeros(rowNum,1);
    ind = foldIndexes(q,:)-labelSum;
    if q < Kfolds
        for t = 1:maxClass
            if t < maxClass
                test_labels(ind(t):ind(t+1)) = t;
            else
                test_labels(ind(t):foldIndexes(q+1,1)-1-labelSum) = t;
            end
        end
    else
        for t = 1:maxClass
            if t < maxClass
                test_labels(ind(t):ind(t+1)) = t;
            else
                test_labels(ind(t):N-labelSum) = t;
            end
        end
    end
    labelSum = labelSum + length(test_labels);
    
    for r = 1:maxClass
        cov = reshape(CovsALL(r + (maxClass*(q-1)),:,:),[D,D]);
        ms = MsALL(r + (maxClass*(q-1)),:);
        lik_k = MyGaussianMV(ms, cov, partition);
        
        test_prob(:,r) = lik_k * prior(r);
    end
    [max_out,test_pred] = max(test_prob, [], 2);
    %cat(2,test_labels,test_pred)

    CM = confusionmat(test_labels,test_pred);
    save(sprintf('t1_mgc_%dcv%d_ck%d_CM.mat',Kfolds,q,CovKind), 'CM');
    
    tots = sum(CM')';
    CM_average = CM./tots;
    CM_final = CM_final + CM_average;

end

% CALCULATE FINAL PARTITION (AVERAGE CM OVER KFOLDS):
CM = CM_final/Kfolds;
save(sprintf('t1_mgc_%dcv%d_ck%d_CM.mat',Kfolds,Kfolds+1,CovKind), 'CM');
  % For each <p> and <CovKind>
  %  save('t1_mgc_<Kfolds>cv<p>_Ms.mat', 'Ms'); COMPLETE
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_Covs.mat', 'Covs'); COMPLETE
  %  save('t1_mgc_<Kfolds>cv<p>_ck<CovKind>_CM.mat', 'CM');
  %  save('t1_mgc_<Kfolds>cv<L>_ck<CovKind>_CM.mat', 'CM');
  % NB: replace <Kfolds>, <p>, and <CovKind> properly.

end
