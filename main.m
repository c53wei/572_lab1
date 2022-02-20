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

% MED multi classifier
num_points = 500;
max_data = 5 + max([class_c.Data class_d.Data class_e.Data], [], 2);
min_data = -5 + min([class_c.Data class_d.Data class_e.Data], [], 2);
x1 = linspace(min_data(1), max_data(1), num_points);
x2 = linspace(min_data(2), max_data(2), num_points);
[A,B] = meshgrid(x1,x2);
c=cat(2,A',B');
x=reshape(c,[],2)';

dist_c = vecnorm(x - class_c.Mean); 
dist_d = vecnorm(x - class_d.Mean); 
dist_e = vecnorm(x - class_e.Mean); 

[~, min_I] = min([dist_c; dist_d; dist_e]);
test = reshape(min_I, size(A));

I = find(min_I == 3); 
scatter(x(1, I), x(2, I), 'black', 'filled', 'MarkerFaceAlpha',.01,'MarkerEdgeAlpha',.01);
[~, min_I] = min([dist_c; dist_d; dist_e]);
I = find(min_I == 2); 
scatter(x(1, I), x(2, I), 'r', 'filled', 'MarkerFaceAlpha',.01,'MarkerEdgeAlpha',.01);
[min_val, min_I] = min([dist_c; dist_d; dist_e]);
I = find(min_I == 1); 
scatter(x(1, I), x(2, I), 'b', 'filled', 'MarkerFaceAlpha',.01,'MarkerEdgeAlpha',.01);


% mid = (class_c.Mean + class_d.Mean)/2;
% normal = class_d.Mean - class_c.Mean;
% normal = [-normal(2); normal(1)];
% normal = normal./norm(normal);
% p1 = mid + l*normal;
% % p2 = mid - l*normal;
% line([p1(1), mid(1)], [p1(2), mid(2)], 'color','k','LineWidth',2)
% 
% mid = (class_c.Mean + class_e.Mean)/2;
% normal = class_e.Mean - class_c.Mean;
% normal = [-normal(2); normal(1)];
% normal = normal./norm(normal);
% p1 = mid + l*normal;
% % p2 = mid - l*normal;
% line([p1(1), mid(1)], [p1(2), mid(2)], 'color','k','LineWidth',2)
% 
% mid = (class_d.Mean + class_e.Mean)/2;
% normal = class_e.Mean - class_d.Mean;
% normal = [-normal(2); normal(1)];
% normal = normal./norm(normal);
% p1 = mid + l*normal;
% p2 = mid - l*normal;
% line([p1(1), mid(1)], [p1(2), mid(2)], 'color','k','LineWidth',2)
% 

xlabel('x_1');
ylabel('x_2');
legend('Class C', 'Class D', 'Class E');
saveas(gcf, "img/class_c_d_e.png");
hold off;

% Part 3: Classifiers







