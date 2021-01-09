

classAcc = zeros(3,11);
partAcc = zeros(3,6);

for k = 1:3
    for p = 1:5
        load(sprintf('t1_mgc_5cv%d_ck%d_CM.mat',p,k));
        partAcc(k,p) = sum(diag(CM))/sum(sum(CM));
    end
    pa = partAcc(k,:);
    partAcc(k,6) = mean(pa(1:5));
    
    load(sprintf('t1_mgc_5cv6_ck%d_CM.mat',k));
    for c = 1:10
        classAcc(k,c) = CM(c,c);
    end
    classAcc(k,11) = mean(diag(CM));
end