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

YneurOut1 = zeros(N,4);
for i = 1:4 %1st hidden layer
    neuronOUT = task2_sNeuron(weights(i,:),X) >= 0.5;
    
    YneurOut1(:,i) = neuronOUT;
end

weights = [-1 0.51 0.51]; %fixed weight vector for layer 2/3(inp.s are 1 or 0) 
YneurOut2 = zeros(N,3);

xINP = YneurOut1(:,[1,4]);
YneurOut2(:,1) = task2_sNeuron(weights,xINP) >= 0.5;
YneurOut2(:,2) = YneurOut1(:,2);
YneurOut2(:,3) = YneurOut1(:,3);

weights = [-1 0.67 0.34 0.34];

Y = task2_sNeuron(weights,YneurOut2)  >= 0.5;
end