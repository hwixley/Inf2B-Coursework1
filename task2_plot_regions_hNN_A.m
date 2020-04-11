%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_hNN_A.m

%Takes polygon input in the form of a matrix:
%Each row represents a point. Col 1 = x, Col 2 = y.

poly =[1.89311,4.03806; %polygon A coordinate matrix
    1.53486,3.71794;
    2.13083,2.98602;
    2.59935,3.57138];

figure
title({'Neural network classification using step activation functions';
    'to determine the boundaries of polygon A'});xlim([0 4]);
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

scatter(class1(1,:),class1(2,:),30,[0.3060, 0.6740, 0.3080],'filled');
hold on;
scatter(class0(1,:),class0(2,:),30,[0.3010, 0.7450, 0.9330],'filled');

pCoeffs = [0 2; -0.14 0.1; -0.08 -0.08; 0 0 ];
for a = 1:4
    text(poly(a,1)+pCoeffs(a,1),poly(a,2)+pCoeffs(a,1),sprintf('V%d',a));
    hold on;
end

legend({'Class 1','Class 0'});

