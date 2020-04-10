%
% Versin 0.9  (HS 06/03/2020)
%
function [Y] = task2_sNeuron(W, X)
% Input:
%  X : N-by-D matrix of input vectors (in row-wise) (double)
%  W : (D+1)-by-1 vector of weights (double)
% Output:
%  Y : N-by-1 vector of output (double)
[N,~] = size(X);
[Dw,~] = size(W);

Y = zeros(N,1);
w = W(2:Dw)';
wZero = W(1); %bias value

for i = 1:N
    a = sum(w.*X(i,:)) + wZero;
    sOut= 1/(1+exp(-a));
    
    if sOut < 0.5
        Y(i) = 0;
    else
        Y(i) = 1;
    end
end
end
