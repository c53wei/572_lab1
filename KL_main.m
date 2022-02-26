clear
close all
clc
%% Class A & Class B

% Generating Clusters
class_a = ClassData(200, [5 10]', [8 0; 0 4]);
[class_a_x, class_a_y] = class_a.drawEllipse([5 10]', [8 0; 0 4]);
class_b = ClassData(200, [10, 15]', [8 0; 0 4]);
[class_b_x, class_b_y] = class_b.drawEllipse([10, 15]', [8 0; 0 4]);


%GED calculations for class 1
n_a = 200;
mu_a = [5, 10];
covar_a = [8, 0; 0, 4];
class_a1 =  repmat(mu_a, n_a, 1) + randn(n_a, 2)*chol(covar_a);

n_b = 200; 
mu_b = [10, 15];
covar_b = [8, 0; 0, 4];
class_b1 =  repmat(mu_b, n_b, 1) + randn(n_b, 2)*chol(covar_b);

step = 0.2;
x = min([class_a1(:,1);class_b1(:,1)])-1:step:max([class_a1(:,1);class_b1(:,1)])+1;
y = min([class_a1(:,2);class_b1(:,2)])-1:step:max([class_a1(:,2);class_b1(:,2)])+1;
[X1, Y1] = meshgrid(x,y);

GED1 = GED(covar_a, mu_a, covar_b, mu_b, X1, Y1);

NN1 = NN(1, class_a1, class_b1, X1, Y1);


figure;
hold on;

% Unit contour
plot(class_a_x, class_a_y, 'b-', 'LineWidth', 2);	
plot(class_b_x, class_b_y, 'r-', 'LineWidth', 2);

% Minimum Euclidean Distance
[x1, x2, classification] = ClassData.Boundary([class_a class_b], 'MED');
contour(x1, x2, classification, 'k');

% Maximum a Posteriori 
[x1, x2, classification] = ClassData.Boundary([class_a class_b], 'MAP');
contour(x1, x2, classification, 'k--');

%GED countour
contour(X1,Y1,GED1, [0, 0], 'Color', 'green', 'LineWidth', 2);

contourf(X1,Y1,NN1, [0, 0], 'Color', 'black', 'LineWidth', 2);
contourf(X1,Y1,kNN1, [0, 0], 'Color', 'black', 'LineWidth', 2);

scatter(class_a.Data(1, :), class_a.Data(2, :), 'b', 'filled');
scatter(class_b.Data(1, :), class_b.Data(2, :), 'r', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('Class A', 'Class B', 'MED', 'MAP', 'GED');
saveas(gcf, "img/class_a_b.png");
% hold off;
% 
% % Error Analysis
% expected1 = horzcat(repmat([1], 1, class_a.N), repmat([2], 1, class_b.N))';
% % Get MED classification results
% test_med1 = Classify([class_a class_b], horzcat(class_a.Data, class_b.Data), 'MED')';
% C = confusionmat(expected1, test_med1);
% error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
% confusionchart(C);
% title(sprintf('%s %s','MED–Error: ', num2str(error), '%'));
% saveas(gcf, "img/class_a_b_med_confusion.png");
% % Get MAP classification results
% test_map1 = Classify([class_a class_b], horzcat(class_a.Data, class_b.Data), 'MAP')';
% C = confusionmat(expected1, test_map1);
% error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
% confusionchart(C);
% title(sprintf('%s %s','MAP–Error: ', num2str(error), '%'));
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

% Maximum a Posteriori
[x1, x2, classification] = ClassData.Boundary([class_c class_d class_e], 'MAP');
contour(x1, x2, classification, 'k--');

% Case 2 GED calculations
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

x = min([class_c1(:,1);class_d1(:,1);class_e1(:,1)])-1:step:max([class_c1(:,1);class_d1(:,1);class_e1(:,1)])+1;
y = min([class_c1(:,2);class_d1(:,2);class_e1(:,2)])-1:step:max([class_c1(:,2);class_d1(:,2);class_e1(:,2)])+1;
[X2, Y2] = meshgrid(x,y);

GED_cd = GED(covar_c, mu_c, covar_d, mu_d, X2, Y2);
GED_ec = GED(covar_e, mu_e, covar_c, mu_c, X2, Y2);
GED_de = GED(covar_d, mu_d, covar_e, mu_e, X2, Y2);

GED2 = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        if GED_cd(i, j) >= 0 && GED_de(i, j) <= 0
            GED2(i, j) = 2;
        elseif GED_cd(i, j) <= 0 && GED_ec(i, j) >= 0
            GED2(i, j) = 1;
        elseif GED_de(i, j) >= 0 && GED_ec(i, j) <= 0
            GED2(i, j) = 3;
        end
    end
end
contour(X2, Y2, GED2, 'Color', 'green');

NN_cd = NN(1, class_c1, class_d1, X2, Y2);
NN_de = NN(1, class_d1, class_e1, X2, Y2);
NN_ec = NN(1, class_e1, class_c1, X2, Y2);

% All classes
NN2 = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        if NN_cd(i, j) >= 0 && NN_de(i, j) <= 0
            NN2(i, j) = 2;
        elseif NN_cd(i, j) <= 0 && NN_ec(i, j) >= 0
            NN2(i, j) = 1;
        elseif NN_de(i, j) >= 0 && NN_ec(i, j) <= 0
            NN2(i, j) = 3;
        end
    end
end
contourf(X2, Y2, NN2, 'Color', 'black');



scatter(class_c.Data(1, :), class_c.Data(2, :), 'b', 'filled');
scatter(class_d.Data(1, :), class_d.Data(2, :), 'r', 'filled');
scatter(class_e.Data(1, :), class_e.Data(2, :), 'k', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('Class C', 'Class D', 'Class E', 'MED', 'MAP', 'GED');
saveas(gcf, "img/class_c_d_e.png");
hold off;

% % Error Analysis
% expected2 = horzcat(repmat([1], 1, class_c.N), ...
%     repmat([2], 1, class_d.N), repmat([3], 1, class_e.N))';
% % Get MED classification results
% test_med2 = Classify([class_c class_d class_e], ...
%     horzcat(class_c.Data, class_d.Data, class_e.Data), 'MED')';
% C = confusionmat(expected2, test_med2);
% error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
% confusionchart(C);
% title(sprintf('%s %s','MED–Error: ', num2str(error), '%'));
% saveas(gcf, "img/class_c_d_e_med_confusion.png");
% % Get MAP classification results
% test_map2 = Classify([class_c class_d class_e], ...
%     horzcat(class_c.Data, class_d.Data, class_e.Data), 'MAP')';
% C = confusionmat(expected2, test_map2);
% error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
% confusionchart(C);
% title(sprintf('%s %s','MAP–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_c_d_e_map_confusion.png");




