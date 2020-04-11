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

YneurOut1 = zeros(N,4);
for i = 1:4 %1st hidden layer
    neuronOUT = task2_sNeuron(weights(i,:),X);% >= 0.5;
    
    YneurOut1(:,i) = neuronOUT;
end
w = YneurOut1(:,1).*YneurOut1(:,2).*YneurOut1(:,3);

weights = [0 w];
Y = task2_sNeuron(weights,YneurOut1(:,4));
% weights = [0 1];
% Y = task2_sNeuron(weights,neurOUT)
end
