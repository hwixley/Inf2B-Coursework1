function [Y] = task2_hNN_B(X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
% Output:
%  Y : N-by-1 vector of output (double)
[N,~] = size(X);
Y = zeros(N,1);

polyB =  [1.89275 6.17329;
    7.07547 0.17441;
    2.16082 2.18265;
    -1.52501 2.03226];
weights = task2_find_hNN_A_weights(polyB); %weight vectors for layer 1

YneurOut1 = zeros(N,4);
for i = 1:4 %1st hidden layer
    neuronOUT = task2_hNeuron(weights(i,:),X);
    
    YneurOut1(:,i) = neuronOUT;
end

weights = [-1 1 1]; %fixed weight vector for layer 2/3(inp.s are 1 or 0) 
YneurOut2 = zeros(N,2);
for k = 1:2
    ind1 = k*2 -1;
    ind2 = k*2;
    
    xINP = YneurOut1(:,(ind1:ind2));
    neuronOUT = task2_hNeuron(weights,xINP);
    YneurOut2(:,k) = neuronOUT;
end

Y = task2_hNeuron(weights,YneurOut2);
end