%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_sNN_AB

%Takes polygon input in the form of a matrix:
%Each row represents a point. Col 1 = x, Col 2 = y.

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
    text(polyB(a,1)+pCoeffs(a,1),polyB(a,2)+pCoeffs(a,1),sprintf('B%d',a));
    hold on;
end


