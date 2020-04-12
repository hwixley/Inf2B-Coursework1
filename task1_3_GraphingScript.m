
load('t1_Cumvar.mat');
[D,~] = size(Cumvar);

y = Cumvar./Cumvar(D);
x = (1:24)';

scatter(x,y,'+');