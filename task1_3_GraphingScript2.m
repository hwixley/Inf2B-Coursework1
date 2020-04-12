hold off;

load('t1_EVecs.mat');
load('t1_S.mat');
load('dset.mat');
[N,D] = size(EVecs);

PC = zeros(D,2);
PC(:,1) = EVecs(:,1);
PC(:,2) = EVecs(:,2);

PC_X = X*PC;
colours = parula(10);

for c = 1:10
    indexes = find(Y_species == c);
    X_class = zeros(length(indexes),D);
    
    for i = 1:length(indexes)
        X_class(i,:) = X(indexes(i),:);
    end
    PC_Xc = X_class*PC;
    
    scatter(PC_Xc(:,1),PC_Xc(:,2),1,colours(c,:),'+');
    hold on;
end 


title('Species principal component analysis');
xl = xlabel('1st principal component');
yl = ylabel('2nd principal component');
xl.FontSize = 9;
yl.FontSize = 9;

cb = colorbar('eastoutside','Ticks',(1:10)./10,'TickLabels',list_species(1:10));
cb.FontSize = 7;
hold on;

print('gcf','-dpdf');

