function [Y] = task2_hNN_B(X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
% Output:
%  Y : N-by-1 vector of output (double)
[N,~] = size(X);
Y = zeros(N,1);

X = X + 1*10^-20; %Normalisation to account for points ON the boundary lines

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
YneurOut2 = zeros(N,3);

xINP = YneurOut1(:,[1,4]);
YneurOut2(:,1) = task2_hNeuron(weights,xINP);
YneurOut2(:,2) = YneurOut1(:,2);
YneurOut2(:,3) = YneurOut1(:,3);

weights = [-2.9 2 1 1];

Y = task2_hNeuron(weights,YneurOut2);
end