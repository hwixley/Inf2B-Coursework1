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


% scatter(PC_X(:,1),PC_X(:,2),'+');
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
%legend(list_species(1:10));
cb = colorbar('eastoutside','Ticks',(1:10)./10,'TickLabels',list_species(1:10));
cb.FontSize = 7;
hold on;

print('gcf','-dpdf');
% cb.Ticks = 1:10;
% hold on;
% cb.TickLabels = list_species(1:10);
% hold on;
