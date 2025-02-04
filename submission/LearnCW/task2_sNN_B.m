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
weights = task2_find_hNN_A_weights(polyB); %weight vectors for layer 1
weights = 10^8*weights;

YneurOut1 = zeros(N,4);
for i = 1:4 %1st hidden layer
    neuronOUT = task2_sNeuron(weights(i,:),X);
    
    YneurOut1(:,i) = neuronOUT;
end

weights = [-1 0.33 0.33 0.35]; %fixed weight vector for layer 2/3(inp.s are 1 or 0) 
weights = 10^8*weights;
neuronOUT1 = task2_sNeuron(weights, YneurOut1(:,[1,2,4]));
neuronOUT2 = task2_sNeuron(weights, YneurOut1(:,[1,3,4]));

nOUT = cat(2,neuronOUT1,neuronOUT2);

weights = [-0.99 1 1];
weights = 10^8*weights;
Y = task2_sNeuron(weights, nOUT);
end