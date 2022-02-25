clear
close all
clc
%% Class A & Class B

% Generating Clusters
class_a = ClassData(200, [5 10]', [8 0; 0 4]);
[class_a_x, class_a_y] = class_a.drawEllipse([5 10]', [8 0; 0 4]);
class_b = ClassData(200, [10, 15]', [8 0; 0 4]);
[class_b_x, class_b_y] = class_b.drawEllipse([10, 15]', [8 0; 0 4]);

figure;
hold on;

% Unit contour
plot(class_a_x, class_a_y, 'b-', 'LineWidth', 2);	
plot(class_b_x, class_b_y, 'r-', 'LineWidth', 2);

% Minimum Euclidean Distance
[x1, x2, classification] = ClassData.Boundary([class_a class_b], 'MED');
contour(x1, x2, classification, 'k');

% Minimum Intra-Class Distance
[x1, x2, classification] = ClassData.Boundary([class_a class_b], 'MICD');
contour(x1, x2, classification, 'k:');

% Maximum a Posteriori 
[x1, x2, classification] = ClassData.Boundary([class_a class_b], 'MAP');
contour(x1, x2, classification, 'k--');

scatter(class_a.Data(1, :), class_a.Data(2, :), 'b', 'filled');
scatter(class_b.Data(1, :), class_b.Data(2, :), 'r', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('Class A', 'Class B', 'MED', 'MICD', 'MAP');
saveas(gcf, "img/class_a_b.png");
hold off;

% Error Analysis
expected1 = horzcat(repmat([1], 1, class_a.N), repmat([2], 1, class_b.N))';
% Get MED classification results
test_med1 = Classify([class_a class_b], horzcat(class_a.Data, class_b.Data), 'MED')';
C = confusionmat(expected1, test_med1);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MED–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_a_b_med_confusion.png");
% Get MICD classification results
test_micd1 = Classify([class_a class_b], horzcat(class_a.Data, class_b.Data), 'MICD')';
C = confusionmat(expected1, test_micd1);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MICD–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_a_b_micd_confusion.png");
% Get MAP classification results
test_map1 = Classify([class_a class_b], horzcat(class_a.Data, class_b.Data), 'MAP')';
C = confusionmat(expected1, test_map1);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MAP–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_a_b_map_confusion.png");

%% Class C, Class D, & Class E
class_c = ClassData(100, [5 10]', [8 4; 4 40]);
[class_c_x, class_c_y] = class_c.drawEllipse([5 10]', [8 4; 4 40]);
class_d = ClassData(200, [15 10]', [8 0; 0 8]);
[class_d_x, class_d_y] = class_d.drawEllipse([15 10]', [8 0; 0 8]);
class_e = ClassData(150, [10 5]', [10 -5; -5 20]);
[class_e_x, class_e_y] = class_e.drawEllipse([10 5]', [10 -5; -5 20]);

figure;
hold on; 

plot(class_c_x, class_c_y, 'b-', 'LineWidth', 2);
plot(class_d_x, class_d_y, 'r-', 'LineWidth', 2);
plot(class_e_x, class_e_y, 'k-', 'LineWidth', 2);

% Minimum Euclidean Distance
[x1, x2, classification] = ClassData.Boundary([class_c class_d class_e], 'MED');
contour(x1, x2, classification, 'k');

% Minimum Intra-Class Distance
[x1, x2, classification] = ClassData.Boundary([class_c class_d class_e], 'MICD');
contour(x1, x2, classification, 'k:');

% Maximum a Posteriori
[x1, x2, classification] = ClassData.Boundary([class_c class_d class_e], 'MAP');
contour(x1, x2, classification, 'k--');

scatter(class_c.Data(1, :), class_c.Data(2, :), 'b', 'filled');
scatter(class_d.Data(1, :), class_d.Data(2, :), 'r', 'filled');
scatter(class_e.Data(1, :), class_e.Data(2, :), 'k', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('Class C', 'Class D', 'Class E', 'MED', 'MICD', 'MAP');
saveas(gcf, "img/class_c_d_e.png");
hold off;

% Error Analysis
expected2 = horzcat(repmat([1], 1, class_c.N), ...
    repmat([2], 1, class_d.N), repmat([3], 1, class_e.N))';
% Get MED classification results
test_med2 = Classify([class_c class_d class_e], ...
    horzcat(class_c.Data, class_d.Data, class_e.Data), 'MED')';
C = confusionmat(expected2, test_med2);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MED–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_c_d_e_med_confusion.png");
% Get MICD classification results
test_micd2 = Classify([class_c class_d class_e], ...
    horzcat(class_c.Data, class_d.Data, class_e.Data), 'MICD')';
C = confusionmat(expected2, test_micd2);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MICD–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_c_d_e_micd_confusion.png");
% Get MAP classification results
test_map2 = Classify([class_c class_d class_e], ...
    horzcat(class_c.Data, class_d.Data, class_e.Data), 'MAP')';
C = confusionmat(expected2, test_map2);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MAP–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_c_d_e_map_confusion.png");




