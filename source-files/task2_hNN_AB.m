%
% Versin 0.9  (HS 06/03/2020)
%
function [Y] = task2_hNN_AB(X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
% Output:
%  Y : N-by-1 vector of output (double)
[N,~] = size(X);

Y_polyA = task2_hNN_A(X); %neural network classification of polyA
Y_polyB = task2_hNN_B(X); %neural network classification of polyB
YneurOut = cat(2, Y_polyA, Y_polyB);
%Classification: 1 = inside, 0 = outside

%Class 1 = not A and B, so Y_polyA = 0 and Y_polyB = 1
%Class 0 = A or not B, so Y_polyA = 1 or Y_polyB = 0

weights = [0 -1 0.5];

Y  = task2_hNeuron(weights,YneurOut);
end
