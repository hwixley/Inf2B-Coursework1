%
% Versin 0.9  (HS 06/03/2020)
%
function [Y] = task2_sNN_AB(X)
% Input:
%  X : N-by-D matrix of input vectors (double)
% Output:
%  Y : N-by-1 vector of output (double)
[N,~] = size(X);

Y_polyA = task2_sNN_A(X); %neural network classification of polyA
Y_polyB = task2_sNN_B(X); %neural network classification of polyB

weights = [-0.1 -1.01 1];
weights = 10^8*weights;
YneurOut = cat(2, Y_polyA, Y_polyB)
Y = task2_sNeuron(weights,YneurOut);
end
