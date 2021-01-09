load('t1_Cumvar.mat');
[D,~] = size(Cumvar);

y = Cumvar./Cumvar(D);
x = (1:24)';


figure;
s = scatter(x,y,'+');
xlabel('Number of Components')
ylabel('Proportion of Variance')


title({'Cumulative Variance'});