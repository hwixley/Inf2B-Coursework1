figure('Renderer', 'painters', 'Position', [10 10 900 600]);
load('dset.mat');
[N,D] = size(X);

cK = 1;
kF = 5;

accuracies = zeros(D,2);
ind = 1;


for i = -20:3
    epsilon = 1*10^(i);
    
    task1_mgc_cv(X,Y_species,cK,epsilon,kF);
    load('t1_mgc_5cv6_ck1_CM.mat');
    
    accuracies(ind,1) = epsilon;
    accuracies(ind,2) = mean(diag(CM));
    ind = ind + 1;
end
task1_mgc_cv(X,Y_species,cK,0.01,kF);

x = accuracies(:,1);
y = accuracies(:,2);

bar(y);
xticks(1:24);
format short
xticklabels(-20:3);
gca.FontSize = 3;

%xlim([1e-20 1000]);
%xticks(linspace(min(x),max(x),numel(x)));

title({'A graph to show the relationship between classification'
    'accuracy and the size of epsilon'});
xl = xlabel('Epsilon exponent (s.t. epsilon = -10^x)');
yl = ylabel('Classification accuracy');
xl.FontSize = 10;
yl.FontSize = 10;

classACC_Epsilon_graph = gcf;

print('classACC_Epsilon_graph','-dpdf');


