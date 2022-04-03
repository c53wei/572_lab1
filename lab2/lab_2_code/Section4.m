clear
clc

data = matfile("../lab_2_data/lab2_3.mat", "Writable", true);
a = data.a;
b = data.b;

%% Sequential Discriminants
step = 0.5;
x_domain = min([a(:,1);b(:,1)])-1:step:max([a(:,1);b(:,1)])+1;
y_range = min([a(:,2);b(:,2)])-1:step:max([a(:,2);b(:,2)])+1;
[X, Y] = meshgrid(x_domain, y_range);

% G1 = sequential_classifier(a, b, X, Y);
% figure
% hold on
% map = [0.68 0.85 0.9 %b 
%     1 0.75 0.8 %r
%         ];   
% colormap(map)
% contourf(X, Y, G1, 'black');
% scatter(a(:,1), a(:,2), 'r', 'filled'); 
% scatter(b(:,1), b(:,2), 'b', 'filled'); 
% 
% G2 = sequential_classifier(a, b, X, Y);
% figure
% hold on
% map = [0.68 0.85 0.9 %b 
%     1 0.75 0.8 %r
%         ];   
% colormap(map)
% contourf(X, Y, G2, 'black');
% scatter(a(:,1), a(:,2), 'r', 'filled'); 
% scatter(b(:,1), b(:,2), 'b', 'filled'); 
% 
% G3 = sequential_classifier(a, b, X, Y);
% figure
% hold on
% map = [0.68 0.85 0.9 %b 
%     1 0.75 0.8 %r
%         ];   
% colormap(map)
% contourf(X, Y, G3, 'black');
% scatter(a(:,1), a(:,2), 'r', 'filled');
% scatter(b(:,1), b(:,2), 'b', 'filled'); 

[G1, err1] = sequential_classifier_lim(a, b, X, Y, 20)
figure
hold on
map = [0.68 0.85 0.9 %b 
    1 0.75 0.8 %r
        ];   
colormap(map)
contourf(X, Y, G1, 'black');
scatter(a(:,1), a(:,2), 'r', 'filled'); 
scatter(b(:,1), b(:,2), 'b', 'filled');

% saveas(gcf, "../img/nonparametric_2d.png");
% 
% close("all");