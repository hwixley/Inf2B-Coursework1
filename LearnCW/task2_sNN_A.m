function [Y] = task2_sNN_A(X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
% Output:
%  Y : N-by-1 vector of output (double)
[N,~] = size(X);
Y = zeros(N,1);

polyA =[1.89311,4.03806;
        1.53486,3.71794;
        2.13083,2.98602;
        2.59935,3.57138];
weights = task2_find_hNN_A_weights(polyA); %weight vectors for layer 1
weights = 10^8*weights;

YneurOut1 = zeros(N,4);
for i = 1:4 %1st hidden layer
    neuronOUT = task2_sNeuron(weights(i,:),X);
    
    YneurOut1(:,i) = neuronOUT;
end

weights = [-1 0.25 0.25 0.25 0.251];
weights = 10^8*weights;
Y = task2_sNeuron(weights,YneurOut1);
end
