load('t1_R.mat');

colour = [0.03 0.144 0.255];
xlim([0 24]);
ylim([-1 1]);
y = MyMean(R);
x = 1:24;

bar(y);
hold on;
str = 'Mean correlation value for each feature';
title(str,'FontSize',12);
hold on;

xticks([1 4 8 12 16 20 24]);
xticklabels([1 4 8 12 16 20 24]);
gca.FontSize = 4;
hold on;

xlabel('Feature #','FontSize',10);
ylabel('Correlation','FontSize',10);

corrMatGraphs2 = gcf;

print('corrMatGraphs2','-dpdf');