function c = comp_confmat(numClasses,test_labels,test_preds)
c = zeros(numClasses,numClasses);
[samples,~] = size(test_labels);

for i = 1:samples
    c(test_labels(i),test_preds(i)) = c(test_labels(i),test_preds(i)) + 1;
end
end