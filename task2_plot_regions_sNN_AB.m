%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_sNN_AB

%Takes polygon input in the form of a matrix:
%Each row represents a point. Col 1 = x, Col 2 = y.
% 
polyA =[1.89311,4.03806; %polygon A coordinate matrix
    1.53486,3.71794;
    2.13083,2.98602;
    2.59935,3.57138];

figure
title({'Neural network classification using the boundaries';
    'of polygon A and B'});
xlim([-2 8]);
ylim([-1 8]);
xlabel('X1');
ylabel('X2');
hold on;

x = [-2 8 8 -2];
y = [8 8 -1 -1];
patch(x,y,[0.3010, 0.7450, 0.9330]);


x = polyB(:,1)';
y = polyB(:,2)';
patch(x,y,[0.3060, 0.6740, 0.3080]);

x = polyA(:,1)';
y = polyA(:,2)';
patch(x,y,[0.3010, 0.7450, 0.9330]);

plot([polyA(1,1),polyA(4,1),polyA(3,1),polyA(2,1),polyA(1,1)],[polyA(1,2),polyA(4,2),polyA(3,2),polyA(2,2),polyA(1,2)],'b-');
hold on;

pCoeffs = [0 5; -0.14 0.1; -0.08 -0.08; 0 0 ];
for a = 1:4
    text(polyA(a,1)+pCoeffs(a,1),polyA(a,2)+pCoeffs(a,1),sprintf('A%d',a));
    hold on;
end


polyB =  [1.89275 6.17329;
    7.07547 0.17441;
    2.16082 2.18265;
    -1.52501 2.03226];

plot([polyB(1,1),polyB(4,1),polyB(3,1),polyB(2,1),polyB(1,1)],[polyB(1,2),polyB(4,2),polyB(3,2),polyB(2,2),polyB(1,2)],'g-');
pCoeffs = [0 2; -0.14 0.1; -0.08 -0.08; 0 0 ];
for a = 1:4
    disp 1
    text(polyB(a,1)+pCoeffs(a,1),polyB(a,2)+pCoeffs(a,1),sprintf('B%d',a));
    hold on;
end



% points = zeros(100,2);
% 
% for a = 1:11
%     ind = (a-1)*10+3;
%     for b = -2:8
%         points(ind+b,1) = a-3;
%         points(ind+b,2) = b;
%     end
% end
% 
% 
% % Colormap we will use to colour each classes.
% cmap = [0.80369089, 0.61814689, 0.46674357;
%     0.81411766, 0.58274512, 0.54901962;
%     0.58339103, 0.62000771, 0.79337179;
%     0.83529413, 0.5584314 , 0.77098041;
%     0.77493273, 0.69831605, 0.54108421;
%     0.72078433, 0.84784315, 0.30039217;
%     0.96988851, 0.85064207, 0.19683199;
%     0.93882353, 0.80156864, 0.4219608 ;
%     0.83652442, 0.74771243, 0.61853136;
%     0.7019608 , 0.7019608 , 0.7019608];
% A = points;
% 
% rng(2); % Set seed
% Knn = 1; % K- nearest neighbours
% K = 2; % Number of classes
% C = kmeans(A, K); % Class labels for each training point
% 
% Xplot = linspace(min(A(:,1)), max(A(:,1)), 100)';
% Yplot = linspace(min(A(:,2)), max(A(:,2)), 100)';
% 
% % Obtain the grid vectors for the two dimensions
% [Xv, Yv] = meshgrid(Xplot, Yplot);
% gridX = [Xv(:), Yv(:)]; % Concatenate to get a 2-D point.
% classes = length(Xv(:));
% 
% for i = 1:length(gridX) % Apply k-NN for each test point
%     dists = pdist2(A, gridX(i, :))'; % Compute distances
%     [d, I] = sort(dists, 'ascend');
%     classes(i) = mode(C(I(1:Knn)));
% end
% figure;
% 
% % This function will draw the decision boundaries
% Z = task2_sNN_AB(points);
% [CC,h] = contourf(Xplot(:), Yplot(:), reshape(classes, length(Xplot), length(Yplot)));
% set(h,'LineColor','none');
% colormap(cmap); hold on;


