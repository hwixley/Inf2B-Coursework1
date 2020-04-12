%hold off;
load('dset.mat');
[N,D] = size(X);

cK = 1;
kF = 5;

accuracies = zeros(D,2);
ind = 1;

for i = -20:3
    epsilon = 1*10^(i);
    
    task1_mgc_cv(X,Y_species,cK,epsilon,kF);
    load('t1_mgc_5cv6_ck1_CM.mat');
    
    accuracies(ind,1) = epsilon;
    accuracies(ind,2) = mean(diag(CM));
    ind = ind + 1;
end

x = accuracies(:,1);
y = accuracies(:,2);

plot
