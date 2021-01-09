%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_hNN_A.m

figure
title({'A graph to show the decision boundaries of the step function'
       'neural network implementation, classified by the boundaries'
       'of polygon A'});
xlim([0 5]);
ylim([0 5]);
xlabel('X1');
ylabel('X2');
hold on;

class1 = zeros(2,500);
class0 = zeros(2,2300);
ind1 = 1;
ind0 = 1;
for x = 1:500
    for y = 1:500
        if task2_hNN_A([x/100,y/100]) == 1
            class1(:,ind1) = [x/100;y/100];
            ind1 = ind1 + 1;
        else
            class0(:,ind0) = [x/100;y/100];
            ind0 = ind0 + 1;
        end
    end
end
class1 = class1(:,[1:ind1-1]);
class0 = class0(:,[1:ind0-1]);

scatter(class0(1,:),class0(2,:),30,[0.3010, 0.7450, 0.9330],'filled');
hold on;
scatter(class1(1,:),class1(2,:),30,[0.3060, 0.6740, 0.3080],'filled');

legend({'Class 0','Class 1'});
