load('t1_R.mat');
figure('Renderer', 'painters', 'Position', [10 10 900 600]);

for i = 1:24
    colour = [0.03 0.144 0.255];
    subplot(6,4,i)
    
    xlim([0 24]);
    ylim([-1 1]);
    x = 1:24;
    y = R(:,i);
    
    bar(y);
    hold on;
    str = sprintf('Corr. of feature %d',i);
    title(str,'FontSize',7);
    hold on;
    
    ax = gca;
    ax.FontSize = 4;
    
    xticks([1 4 8 12 16 20 24]);
    xticklabels([1 4 8 12 16 20 24]);
    gca.FontSize = 4;
    hold on;
    
    xlabel('Feature #','FontSize',5);
    ylabel('Correlation','FontSize',5);
end

corrMatGraphs = gcf;

print('corrMatGraphs','-dpdf');

    
    