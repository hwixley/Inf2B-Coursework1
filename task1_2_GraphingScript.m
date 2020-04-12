load('t1_R.mat');
figure('Renderer', 'painters', 'Position', [10 10 900 600])

for i = 1:24
    colour = [0.03 0.144 0.255];
    subplot(6,4,i)
        
    ax= gca;
    ax.FontSize = 3;
    
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
    hold on;
    
    ax = gca;
    ax.FontSize = 4;
    
    xticks([1 4 8 12 16 20 24]);
    hold on;
    yticks([-1, -0.5, 0 ,0.5, 1]);
end

    
    