%
% Versin 0.9  (HS 06/03/2020)
%
% template script task2_find_hNN_A_weights.m
%
function w = task2_find_hNN_A_weights(x)
%INPUT x = matrix of polygon vertices
[N,D] = size(x); % each row represents the coords for each vertex

funcs = task2_calcGrads(x);%calcs bound fn coeffs(c1 = y-int, c2 = grad.)
fOnes = -1.*ones(N,1);
weights = cat(2,funcs,fOnes);%(c1 = const, c2 = x-coeff, c3 = y-coeff)

%Adds the appropriate sign to each weight vector.
for i = 1:N
    if i == 2 || i == 3
        weights(i,:) = weights(i,:).*-1;
    end
end

%Normalization to only account for points inside polygon (not including
%the periphery)
for a = 1:2
    weights(a^2,1) = weights(a^2,1) - 1*10^-14;
end
for b = 2:3
    weights(b,1) = weights(b,1) + 1*10^-14;
end

%Normalization
for r = 1:N
    weights(r,:) = weights(r,:)./max(abs(weights(r,:))); 
end
w = weights;
end



