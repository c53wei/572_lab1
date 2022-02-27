%% Class A & Class B
n_a = 200;
mu_a = [5, 10];
covar_a = [8, 0; 0, 4];
class_a1 =  repmat(mu_a, n_a, 1) + randn(n_a, 2)*chol(covar_a);

n_b = 200; 
mu_b = [10, 15];
covar_b = [8, 0; 0, 4];
class_b1 =  repmat(mu_b, n_b, 1) + randn(n_b, 2)*chol(covar_b);

class_a = ClassData(n_a, mu_a', covar_a);
[class_a_x, class_a_y] = class_a.drawEllipse(mu_a', covar_a);
class_b = ClassData(n_b, mu_b', covar_b);
[class_b_x, class_b_y] = class_b.drawEllipse(mu_b', covar_b);

step = 0.2;
x = min([class_a1(:,1);class_b1(:,1)])-1:step:max([class_a1(:,1);class_b1(:,1)])+1;
y = min([class_a1(:,2);class_b1(:,2)])-1:step:max([class_a1(:,2);class_b1(:,2)])+1;
[X1, Y1] = meshgrid(x,y);

NN1 = NN(1, class_a1, class_b1, X1, Y1);
kNN1 = NN(5, class_a1, class_b1, X1, Y1);

figure;
hold on;

% Unit contour

contourf(X1,Y1,NN1, [0, 0], 'Color', 'magenta', 'LineWidth', 2);
contourf(X1,Y1,kNN1, [0, 0], 'Color', 'cyan', 'LineWidth', 2);

plot(class_a_x, class_a_y, 'b-', 'LineWidth', 2);	
plot(class_b_x, class_b_y, 'r-', 'LineWidth', 2);

scatter(class_a.Data(1, :), class_a.Data(2, :), 'b', 'filled');
scatter(class_b.Data(1, :), class_b.Data(2, :), 'r', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('NN', 'kNN','Class A', 'Class B');
saveas(gcf, "img/class_a_b.png");

%% Class C, Class D, & Class E
n_c = 100; 
mu_c = [5, 10];
covar_c = [8, 4; 4, 40];
class_c1 =  repmat(mu_c, n_c, 1) + randn(n_c, 2) * chol(covar_c);

n_d = 200; 
mu_d = [15, 10];
covar_d = [8, 0; 0, 8];
class_d1 =  repmat(mu_d, n_d, 1) + randn(n_d, 2) * chol(covar_d);

n_e = 150; 
mu_e = [10, 5];
covar_e = [10, -5; -5, 20];
class_e1 =  repmat(mu_e, n_e, 1) + randn(n_e, 2) * chol(covar_e);

class_c = ClassData(n_c, mu_c', covar_c);
[class_c_x, class_c_y] = class_c.drawEllipse(mu_c', covar_c);
class_d = ClassData(n_d, mu_d', covar_d);
[class_d_x, class_d_y] = class_d.drawEllipse(mu_d', covar_d);
class_e = ClassData(n_e, mu_e', covar_e);
[class_e_x, class_e_y] = class_e.drawEllipse(mu_e', covar_e);

figure;
hold on; 

x = min([class_c1(:,1);class_d1(:,1);class_e1(:,1)])-1:step:max([class_c1(:,1);class_d1(:,1);class_e1(:,1)])+1;
y = min([class_c1(:,2);class_d1(:,2);class_e1(:,2)])-1:step:max([class_c1(:,2);class_d1(:,2);class_e1(:,2)])+1;
[X2, Y2] = meshgrid(x,y);
NN2 = c2NN(1, class_c1, class_d1, class_e1, X2, Y2);
kNN2 = c2NN(5, class_c1, class_d1, class_e1, X2, Y2);

contourf(X2, Y2, NN2, 'Color', 'magenta');
contourf(X2, Y2, kNN2, 'Color', 'cyan');

plot(class_c_x, class_c_y, 'b-', 'LineWidth', 2);
plot(class_d_x, class_d_y, 'r-', 'LineWidth', 2);
plot(class_e_x, class_e_y, 'k-', 'LineWidth', 2);

scatter(class_c.Data(1, :), class_c.Data(2, :), 'b', 'filled');
scatter(class_d.Data(1, :), class_d.Data(2, :), 'r', 'filled');
scatter(class_e.Data(1, :), class_e.Data(2, :), 'k', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('NN','kNN','Class C', 'Class D', 'Class E');
saveas(gcf, "img/class_c_d_e.png");
hold off;



