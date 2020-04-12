
figure('Renderer', 'painters', 'Position', [10 10 900 600])

for i = 1:24
    colour = a(i*2,:);
    subplot(6,4,i)
    xlim([0 24]);
    ylim([-1 1]);
    x = 1:24;
    y = R(:,i);
    
    best = y;
    best(i) = -1;
    bY = max(best);
    bX = find(y == bY);

    plot(x,y,20,colour);
    hold on;
    plot(bX,bY,'r*');
    hold on;
    str = sprintf('Corr. of feature %d',i);
    title(str,'FontSize',5);
    
    ax= gca;
    ax.FontSize = 4;
    xticks([1 4 8 12 16 20 24]);
end
    
    