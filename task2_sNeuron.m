%
% Versin 0.9  (HS 06/03/2020)
%
function [Y] = task2_sNeuron(W, X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
%  W : (D+1)-by-1 vector of weights (double)
% Output:
%  Y : N-by-1 vector of output (double)
[N,D] = size(X);
[Dw,~] = size(W);

Y = zeros(N,1);
w = W(2:Dw)';
wZero = W(1);

a = task2_hNeuron(W,X);

for i = 1:N
    aN = a(i);
    
    Y(i)= 1/(1+exp(-aN));
end
end
