function t14_plotGaussian(CM, maxClass)

[D1,D2] = size(CM);

if D1 ~= maxClass || D2 ~= maxClass
    error('Confusion matrix input not a square of size maxClass.');
end

for c = 1:maxClass
    T = CM(c,:);
    
    subplot(5,2,c);
    
    for t = 1:maxClass
        if t == c
            scatter(T(t),'b','o');
        else
            scatter(T(t),'r','x');
        end
    end
    
end