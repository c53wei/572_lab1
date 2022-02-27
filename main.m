clear
close all
clc
%% Class A & Class B

% Generating Clusters
class_a = ClassData(200, [5 10]', [8 0; 0 4]);
[class_a_x, class_a_y] = class_a.drawEllipse([5 10]', [8 0; 0 4]);
class_b = ClassData(200, [10, 15]', [8 0; 0 4]);
[class_b_x, class_b_y] = class_b.drawEllipse([10, 15]', [8 0; 0 4]);

% Case 1 GED calculations 
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

% GED contour
contour(X1,Y1,GED1, [0, 0], 'Color', 'green', 'LineWidth', 2);

scatter(class_a.Data(1, :), class_a.Data(2, :), 'b', 'filled');
scatter(class_b.Data(1, :), class_b.Data(2, :), 'r', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('Class A', 'Class B', 'MED', 'MAP', 'GED');
saveas(gcf, "img/class_a_b.png");
hold off;

% Nearest Neighbour
nn = knn(class_a1,class_b1,1,X1,Y1);
figure
contour(X1,Y1,nn, [0, 0], 'Color', 'green', 'LineWidth', 2); hold on
scatter(class_a1(:,1), class_a1(:,2), 'b', 'filled'); hold on
scatter(class_b1(:,1), class_b1(:,2), 'r', 'filled');
saveas(gcf, "img/class_a_b_nn.png");
hold off

% k-Nearest Neighbours
knn5 = knn(class_a1,class_b1,5,X1,Y1);
figure
contour(X1,Y1,knn5, [0, 0], 'Color', 'green', 'LineWidth', 2); hold on
scatter(class_a1(:,1), class_a1(:,2), 'b', 'filled'); hold on
scatter(class_b1(:,1), class_b1(:,2), 'r', 'filled');
saveas(gcf, "img/class_a_b_knn.png");
hold off

% Error Analysis
expected1 = horzcat(repmat([1], 1, class_a.N), repmat([2], 1, class_b.N))';
expected1 = char(expected1 + 64);
% Get MED classification results
test_med1 = Classify([class_a class_b], horzcat(class_a.Data, class_b.Data), 'MED')';
test_med1 = char(test_med1 + 64);
C = confusionmat(expected1, test_med1);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MED–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_a_b_med_confusion.png");

% Get MAP classification results
test_map1 = Classify([class_a class_b], horzcat(class_a.Data, class_b.Data), 'MAP')';
test_map1 = char(test_map1 + 64);
C = confusionmat(expected1, test_map1);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MAP–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_a_b_map_confusion.png");

% Get NN error analysis
[confusionmat_nn1,p_err_nn1] = nn_err_analysis(class_a1, class_b1);
disp(confusionmat_nn1);
confusionchart(confusionmat_nn1);
title(sprintf('%s %s','NN–Error: ', num2str(p_err_nn1*100), '%'));
disp(p_err_nn1);
saveas(gcf, "img/class_a_b_nn_confusion.png");

% Get kNN error analysis
[confusionmat_knn1,p_err_knn1] = nn_err_analysis(class_a1, class_b1);
disp(confusionmat_knn1);
confusionchart(confusionmat_knn1);
title(sprintf('%s %s','kNN–Error (k=5): ', num2str(p_err_knn1*100), '%'));
disp(p_err_knn1);
saveas(gcf, "img/class_a_b_knn_confusion.png");



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
        else
            disp('classification failed GED');
        end
    end
end
contour(X2, Y2, GED2, 'Color', 'green');

scatter(class_c.Data(1, :), class_c.Data(2, :), 'b', 'filled');
scatter(class_d.Data(1, :), class_d.Data(2, :), 'r', 'filled');
scatter(class_e.Data(1, :), class_e.Data(2, :), 'k', 'filled');

xlabel('x_1');
ylabel('x_2');
legend('Class C', 'Class D', 'Class E', 'MED', 'MAP', 'GED');
saveas(gcf, "img/class_c_d_e.png");
hold off;

% Nearest Neighbour
nn_cd = knn(class_c1,class_d1,1,X2,Y2);
nn_de = knn(class_d1,class_e1,1,X2,Y2);
nn_ce = knn(class_e1,class_c1,1,X2,Y2);

nn2 = zeros(size(X2, 1), size(Y2, 2));
c=1;d=2;e=3;
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        if nn_cd(i, j) >= 0 && nn_de(i, j) <= 0
            nn2(i, j) = d;
        elseif nn_cd(i, j) <= 0 && nn_ce(i, j) >= 0
            nn2(i, j) = c;
        elseif nn_de(i, j) >= 0 && nn_ce(i, j) <= 0
            nn2(i, j) = e;
        else
            disp('classification failed');
        end
    end
end

figure
contourf(X2,Y2,nn2, 'Color', 'black'); hold on
scatter(class_c1(:,1), class_c1(:,2), 'b', 'filled'); hold on
scatter(class_d1(:,1), class_d1(:,2), 'r', 'filled'); hold on
scatter(class_e1(:,1), class_e1(:,2), 'g', 'filled');
saveas(gcf, "img/class_c_d_e_nn.png");
hold off

% k-Nearest Neighbours
knn_cd = knn(class_c1,class_d1,5,X2,Y2);
knn_de = knn(class_d1,class_e1,5,X2,Y2);
knn_ce = knn(class_e1,class_c1,5,X2,Y2);

knn5_2 = zeros(size(X2, 1), size(Y2, 2));
for i=1:size(X2, 1)
    for j=1:size(Y2, 2)
        if knn_cd(i, j) >= 0 && knn_de(i, j) <= 0
            knn5_2(i, j) = d;
        elseif knn_cd(i, j) <= 0 && knn_ce(i, j) >= 0
            knn5_2(i, j) = c;
        elseif knn_de(i, j) >= 0 && knn_ce(i, j) <= 0
            knn5_2(i, j) = e;
        else
            disp('classification failed');
        end
    end
end

figure
contourf(X2,Y2,knn5_2, 'Color', 'black'); hold on
scatter(class_c1(:,1), class_c1(:,2), 'b', 'filled'); hold on
scatter(class_d1(:,1), class_d1(:,2), 'r', 'filled'); hold on
scatter(class_e1(:,1), class_e1(:,2), 'g', 'filled');
saveas(gcf, "img/class_c_d_e_knn.png");
hold off

% Error Analysis
expected2 = horzcat(repmat([1], 1, class_c.N), ...
    repmat([2], 1, class_d.N), repmat([3], 1, class_e.N))';
expected2 = char(expected2 + 64);
% Get MED classification results
test_med2 = Classify([class_c class_d class_e], ...
    horzcat(class_c.Data, class_d.Data, class_e.Data), 'MED')';
test_med2 = char(test_med2 + 64);
C = confusionmat(expected2, test_med2);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MED–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_c_d_e_med_confusion.png");

% Get MAP classification results
test_map2 = Classify([class_c class_d class_e], ...
    horzcat(class_c.Data, class_d.Data, class_e.Data), 'MAP')';
test_map2 = char(test_map2 + 64);
C = confusionmat(expected2, test_map2);
error = (sum(C, 'all') - trace(C))/sum(C, 'all') * 100;
confusionchart(C);
title(sprintf('%s %s','MAP–Error: ', num2str(error), '%'));
saveas(gcf, "img/class_c_d_e_map_confusion.png");
