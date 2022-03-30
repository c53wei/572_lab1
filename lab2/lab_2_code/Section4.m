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

sequential_classifier(a, b, X, Y);

% saveas(gcf, "../img/nonparametric_2d.png");
% 
% close("all");