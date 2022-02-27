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
axis equal;

% Unit contour
plot(class_a_x, class_a_y, 'b-', 'LineWidth', 2);	
plot(class_b_x, class_b_y, 'r-', 'LineWidth', 2);

scatter(class_a.Data(1, :), class_a.Data(2, :), 'b', 'filled');
scatter(class_b.Data(1, :), class_b.Data(2, :), 'r', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('Class A', 'Class B');
saveas(gcf, "img/class_a_b_contour.png");
hold off;

%% Class C, Class D, & Class E
class_c = ClassData(100, [5 10]', [8 4; 4 40]);
[class_c_x, class_c_y] = class_c.drawEllipse([5 10]', [8 4; 4 40]);
class_d = ClassData(200, [15 10]', [8 0; 0 8]);
[class_d_x, class_d_y] = class_d.drawEllipse([15 10]', [8 0; 0 8]);
class_e = ClassData(150, [10 5]', [10 -5; -5 20]);
[class_e_x, class_e_y] = class_e.drawEllipse([10 5]', [10 -5; -5 20]);

figure;
hold on; 
axis equal;

plot(class_c_x, class_c_y, 'b-', 'LineWidth', 2);
plot(class_d_x, class_d_y, 'r-', 'LineWidth', 2);
plot(class_e_x, class_e_y, 'k-', 'LineWidth', 2);

scatter(class_c.Data(1, :), class_c.Data(2, :), 'b', 'filled');
scatter(class_d.Data(1, :), class_d.Data(2, :), 'r', 'filled');
scatter(class_e.Data(1, :), class_e.Data(2, :), 'k', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('Class C', 'Class D', 'Class E');
saveas(gcf, "img/class_c_d_e_contour.png");
hold off;

