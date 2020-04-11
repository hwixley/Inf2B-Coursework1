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

YneurOut = cat(2, Y_polyA + 1-Y_polyB , Y_polyB-Y_polyA)
%Classification: 1 = inside, 0 = outside

Y = YneurOut(:,2)>YneurOut(:,1);

%Class 1 = not A and B, so Y_polyA = 0 and Y_polyB = 1
%Class 0 = A or not B, so Y_polyA = 1 or Y_polyB = 0
% 
% weights = [-1 -1 1];
% 
% Y  = find(max(task2_sNeuron(weights,YneurOut)))-1;
end
