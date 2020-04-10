function [Y] = task2_sNN_B(X)
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
weights = -1.*task2_find_hNN_A_weights(polyB); %weight vectors for layer 1

YneurOut1 = zeros(N,4);
for i = 1:4 %1st hidden layer
    neuronOUT = task2_sNeuron(weights(i,:),X) >= 0.5;
    
    YneurOut1(:,i) = neuronOUT;
end

weights = [-2 1 1]; %fixed weight vector for layer 2/3(inp.s are 1 or 0) 
YneurOut2 = zeros(N,2);
for k = 1:2
    ind1 = k*2 -1;
    ind2 = k*2;
    
    xINP = YneurOut1(:,(ind1:ind2));
    neuronOUT = task2_sNeuron(weights,xINP) >= 0.5;
    YneurOut2(:,k) = neuronOUT;
end

Y = task2_sNeuron(weights,YneurOut2)  >= 0.5;
end