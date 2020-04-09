%
% Versin 0.9  (HS 06/03/2020)
%
% template script for task2_plot_regions_hNN_A.m
function task2_plot_regions_hNN_A(poly)
%Takes polygon input in the form of a matrix:
%Each row represents a point. Col 1 = x, Col 2 = y.

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


