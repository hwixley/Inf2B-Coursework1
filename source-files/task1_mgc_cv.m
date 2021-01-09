function task1_4(X, Y, CovKind, epsilon, Kfolds)
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
classInd = zeros(N,maxClass);
for b = 1:maxClass
    classInd(:,b) = Y == b;
end

% loop to find mean number of vectors for a given class in a partition
meanFoldVecs = zeros(1,maxClass);
remainders = zeros(1,maxClass);
for c = 1:maxClass
    meanFoldVecs(c) = floor(sum(classInd(:,c))/Kfolds);
    remainders(c) = rem(sum(classInd(:,c)),Kfolds);
end

%CALCULATION OF PMap
PMap = zeros(N,1);
lastCI = ones(maxClass,1);
ALLMap = zeros(N,2); %col.1 = partition #, col.2 = class #

for p = 1:Kfolds-1
    for c = 1:maxClass
        numVecs = meanFoldVecs(c);
        for i = lastCI(c):N
            if classInd(i,c) == 1
                PMap(i) = p;
                lastCI(c) = i+1;
                ALLMap(i,1) = p;
                ALLMap(i,2) = c;
                numVecs = numVecs -1;
            end
            if numVecs == 0
                break;
            end
        end
    end
end
for c = 1:maxClass
   numVecs = meanFoldVecs(c) + remainders(c);
   for i = lastCI(c):N
        if classInd(i,c) == 1
            PMap(i) = Kfolds;
            lastCI(c) = i+1;
            ALLMap(i,1) = Kfolds;
            ALLMap(i,2) = c;
            numVecs = numVecs -1;
        end
        if numVecs == 0
            break;
        end
   end
end

  save(sprintf('t1_mgc_%dcv_PMap.mat',Kfolds), 'PMap');
  % PMap successfully initialised and saved

%CALCULATION OF Ms & Covs  
C = maxClass; 
regularize = diag(ones(1,D).*epsilon);
  
for p = 1:Kfolds
    Ms = zeros(C,D);
    Covs = zeros(C,D,D);
    covShared = 0;
    
    for c = 1:maxClass
        validSamples = sum(cat(2, ALLMap(:,1) ~= p, ALLMap(:,2) == c),2);
        vexIndexes = find(validSamples == 2);
        vex = zeros(length(vexIndexes),D);
        
        for v = 1:length(vexIndexes)
            elem = vexIndexes(v);
            vex(v,:) = X(elem,:);
        end
        
        Ms(c,:) = MyMean(vex);
        covar = MyCov(vex);
        
        if CovKind ~= 3
            covar = regularize + covar;
            
            if CovKind == 2
                Covs(c,:,:) = diag(diag(covar));
            else
                Covs(c,:,:) = covar;
            end
        else
            covShared = covShared + covar;
        end
    end   
    if CovKind == 3
        covar = regularize + (covShared./double(maxClass));
        for c = 1:maxClass
            Covs(c,:,:) = covar;
        end
    end
    
    save(sprintf('t1_mgc_%dcv%d_ck%d_Covs.mat',Kfolds,p,CovKind), 'Covs');
    save(sprintf('t1_mgc_%dcv%d_Ms.mat',Kfolds,p), 'Ms');     
end

%CALCULATION OF CONFUSION MATRICES
CM_final = zeros(maxClass,maxClass);
prior = ones(1,maxClass)./double(maxClass);

CM_tot = zeros(maxClass,maxClass);

for p = 1:Kfolds
    CM = zeros(maxClass,maxClass);
    test_labels = zeros(sum(PMap == p),1);
    test_prob = zeros(sum(PMap == p),maxClass);
    covShared = 0;
    meanShared = zeros(maxClass,D);
    
    testIndexes = find(PMap == p);
    testData = zeros(length(testIndexes),D);
    for t = 1:length(testIndexes)
        testData(t,:) = X(testIndexes(t),:);
        test_labels(t) = Y(testIndexes(t));
    end
    
    for c = 1:maxClass
        trainSamples = sum(cat(2, ALLMap(:,1) ~= p, ALLMap(:,2) == c),2);
        trainIndexes = find(trainSamples == 2);
        trainData = zeros(length(trainIndexes),D); 
        for i = 1:length(trainIndexes)
            trainData(i,:) = X(trainIndexes(i),:);
        end
               
        mu_hat = MyMean(trainData);
        sigma_hat = MyCov(trainData);
        
             
        if CovKind ~= 3
            sigma_hat = regularize + sigma_hat;
        
            if CovKind == 2
                sigma_hat = diag(diag(sigma_hat));
            end
            
            lik_k = iterateGaussian(mu_hat,sigma_hat,testData);

            test_prob(:,c) = lik_k + log(prior(c));          
        else
            covShared = covShared + sigma_hat;
            meanShared(c,:) = mu_hat;
        end   
    end
    if CovKind == 3
        sigma_hat  = regularize + (covShared./double(maxClass));
        for c = 1:maxClass            
            mu_hat = meanShared(c,:);
            
            lik_k = iterateGaussian(mu_hat,sigma_hat,testData);

            test_prob(:,c) = lik_k + log(prior(c));
        end
    end
    [~,test_pred] = max(test_prob, [], 2);

    CM = comp_confmat(maxClass,test_labels,test_pred);
    save(sprintf('t1_mgc_%dcv%d_ck%d_CM.mat',Kfolds,p,CovKind), 'CM');
    
    tots = sum(CM,2);
    CM_average = CM./tots;
    CM_final = CM_final + CM_average;
    
    CM_tot = CM_tot + CM;
end

%t14_plotGaussian(CM_tot,maxClass);

CM = CM_final/Kfolds;
save(sprintf('t1_mgc_%dcv%d_ck%d_CM.mat',Kfolds,Kfolds+1,CovKind), 'CM');

end
