%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_hNN_A.m
function task2_plot_regions_hNN_A()
%Takes polygon input in the form of a matrix:
%Each row represents a point. Col 1 = x, Col 2 = y.
polyB =  [1.89275 6.17329; 7.07547 0.17441; 2.16082 2.18265; -1.52501 2.03226];

poly =[1.89311,4.03806;
    1.53486,3.71794;
    2.13083,2.98602;
    2.59935,3.57138];

figure
title('Neural network classification using the boundaries of polygon A');
xlim([0 4]);
ylim([0 5]);
xlabel('X1');
ylabel('X2');
hold on;
plot([poly(1,1),poly(4,1),poly(3,1),poly(2,1),poly(1,1)],[poly(1,2),poly(4,2),poly(3,2),poly(2,2),poly(1,2)],'b-');
hold on;

pCoeffs = [0 2; -0.14 0.1; -0.08 -0.08; 0 0 ];
for a = 1:4
    text(poly(a,1)+pCoeffs(a,1),poly(a,2)+pCoeffs(a,1),sprintf('V%d',a));
    hold on;
end
end


