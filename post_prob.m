function pp = post_prob(samplesK,priorK,x)
[~,D] = size(x);

pp = -log(2*pi)-log(MyVar(samplesK)) - ((x-MyMean(samplesK)).^2)./MyVar(samplesK);
pp = (1/2*pp) + priorK;

if sum(isnan(pp)) ~= 0
    indexes = find(isnan(pp) == 1);
    for i = 1:length(indexes)
        pp(indexes(i)) = 0;
    end
end
end