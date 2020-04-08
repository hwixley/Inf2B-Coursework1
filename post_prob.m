function pp = post_prob(samplesK,priorK,cov,mu,x)
[~,D] = size(x);
var = MyVar(samplesK);

% Normalization
if ~isempty(find(var == 0, 1))
    indexes = find(var == 0); 
    for i = 1:length(indexes)
        var(indexes(i)) = 0.0001;
    end
end

pp = -log(2*pi)-log(var) - ((x-mu).^2)./var;
pp = (1/2*pp) + priorK;

% if sum(isnan(pp)) ~= 0
%     indexes = find(isnan(pp) == 1);
% %     pp
% %     MyVar(samplesK)
% %     x
% %     mu
%     for i = 1:length(indexes)
%         pp(indexes(i)) = 0.0001;
%     end
% end

%Tryed using GaussianMV posterior probability but found predictions were
%not as effective.
% pp  = (x - mu)'.*inv(cov).*(x-mu);
% pp = -(1/2).*pp -(1/2).*log(abs(cov))+log(priorK);

end