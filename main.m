% Part 2: Generating Clusters
class_a = ClassData(200, [5 10]', [8 0; 0 4]);
[class_a_x, class_a_y] = class_a.drawEllipse([5 10]', [8 0; 0 4]);
class_b = ClassData(200, [10, 15]', [8 0; 0 4]);
[class_b_x, class_b_y] = class_b.drawEllipse([10, 15]', [8 0; 0 4]);

figure;
hold on;
scatter(class_a.Data(1, :), class_a.Data(2, :), 'b', 'filled');
scatter(class_b.Data(1, :), class_b.Data(2, :), 'r', 'filled');

plot(class_a_x, class_a_y, 'b-', 'LineWidth', 2);	
plot(class_b_x, class_b_y, 'r-', 'LineWidth', 2);	

% Minimum Euclidean Distance
% Use heuristics to guess how long line is
data_range = max([class_a.Data class_b.Data], [], 2) ...
    - min([class_a.Data class_b.Data], [], 2);
l = norm(data_range)/2;


mid = (class_a.Mean + class_b.Mean)/2;
normal = class_b.Mean - class_a.Mean;
normal = [-normal(2); normal(1)];
normal = normal./norm(normal);
p1 = mid + l*normal;
p2 = mid - l*normal;
line([p1(1), p2(1)], [p1(2), p2(2)], 'color','k','LineWidth',2)

xlabel('x_1');
ylabel('x_2');
legend('Class A', 'Class B');
saveas(gcf, "img/class_a_b.png");
hold off;

class_c = ClassData(100, [5 10]', [8 4; 4 40]);
[class_c_x, class_c_y] = class_c.drawEllipse([5 10]', [8 4; 4 40]);
class_d = ClassData(200, [15 10]', [8 0; 0 8]);
[class_d_x, class_d_y] = class_d.drawEllipse([15 10]', [8 0; 0 8]);
class_e = ClassData(150, [10 5]', [10 -5; -5 20]);
[class_e_x, class_e_y] = class_e.drawEllipse([10 5]', [10 -5; -5 20]);


figure;
hold on; 
scatter(class_c.Data(1, :), class_c.Data(2, :), 'b', 'filled');
scatter(class_d.Data(1, :), class_d.Data(2, :), 'r', 'filled');
scatter(class_e.Data(1, :), class_e.Data(2, :), 'black', 'filled');

plot(class_c_x, class_c_y, 'b-', 'LineWidth', 2);
plot(class_d_x, class_d_y, 'r-', 'LineWidth', 2);
plot(class_e_x, class_e_y, 'black-', 'LineWidth', 2);

xlabel('x_1');
ylabel('x_2');
legend('Class A', 'Class B', 'Class C');
saveas(gcf, "img/class_c_d_e.png");
hold off;

% Part 3: Classifiers





