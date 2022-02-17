class_a = generateData(200, [5 10]', [8 0; 0 4]);
[class_a_x, class_a_y] = drawEllipse([5 10]', [8 0; 0 4]);
class_b = generateData(200, [10, 15]', [8 0; 0 4]);
[class_b_x, class_b_y] = drawEllipse([10, 15]', [8 0; 0 4]);

figure;
hold on;
scatter(class_a(1, :), class_a(2, :), 'b', 'filled');
scatter(class_b(1, :), class_b(2, :), 'r', 'filled');

plot(class_a_x, class_a_y, 'b-', 'LineWidth', 2);	
plot(class_b_x, class_b_y, 'r-', 'LineWidth', 2);	

xlabel('x_1');
ylabel('x_2');
legend('Class A', 'Class B');
saveas(gcf, "img/class_a_b.png");
hold off;

class_c = generateData(100, [5 10]', [8 4; 4 40]);
[class_c_x, class_c_y] = drawEllipse([5 10]', [8 4; 4 40]);
class_d = generateData(200, [15 10]', [8 0; 0 8]);
[class_d_x, class_d_y] = drawEllipse([15 10]', [8 0; 0 8]);
class_e = generateData(150, [10 5]', [10 -5; -5 20]);
[class_e_x, class_e_y] = drawEllipse([10 5]', [10 -5; -5 20]);


figure;
hold on; 
scatter(class_c(1, :), class_c(2, :), 'b', 'filled');
scatter(class_d(1, :), class_d(2, :), 'r', 'filled');
scatter(class_e(1, :), class_e(2, :), 'black', 'filled');

plot(class_c_x, class_c_y, 'b-', 'LineWidth', 2);
plot(class_d_x, class_d_y, 'r-', 'LineWidth', 2);
plot(class_e_x, class_e_y, 'black-', 'LineWidth', 2);

xlabel('x_1');
ylabel('x_2');
legend('Class A', 'Class B', 'Class C');
saveas(gcf, "img/class_c_d_e.png");
hold off;

