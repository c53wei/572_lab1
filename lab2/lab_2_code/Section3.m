clear
clc

data = matfile("../lab_2_data/lab2_2.mat", "Writable", true);
a = data.al;
b = data.bl;
c = data.cl;

%% Parametric Estimation
[m_A, var_A] = estimate_gaussian_2d(a); % sample mean, variance
[m_B, var_B] = estimate_gaussian_2d(b); 
[m_C, var_C] = estimate_gaussian_2d(c);

step = 0.2;
x_domain = min([a(:,1);b(:,1);c(:,1)])-1:step:max([a(:,1);b(:,1);c(:,1)])+1;
y_range = min([a(:,2);b(:,2);c(:,2)])-1:step:max([a(:,2);b(:,2);c(:,2)])+1;
[X, Y] = meshgrid(x_domain, y_range);

% compute classification 2 at a time
ml_AB = ML(m_A,var_A,m_B,var_B,X,Y);
ml_AC = ML(m_C,var_C,m_A,var_A,X,Y);
ml_BC = ML(m_B,var_B,m_C,var_C,X,Y);

class_boundary_gaussian = zeros(size(X,1), size(Y,2));
for i = 1:size(X,1)
    for j = 1:size(Y,2)
        [~,class] = min([ml_AB(i,j), ml_AC(i,j), ml_BC(i,j)]);
        class_boundary_gaussian(i,j) = class;
    end
end

figure();
hold on;
map = [0.82 0.94 0.75 %g
    1 0.75 0.8 %r
    0.68 0.85 0.9 %b 
    ];
        
colormap(map)
contourf(X,Y, class_boundary_gaussian, 'Color','black');
scatter(a(:,1), a(:,2), 'r', 'filled');
scatter(b(:,1), b(:,2), 'g', 'filled'); 
scatter(c(:,1), c(:,2), 'b', 'filled');
hold off;
title("ML Classification");
xlabel('x');
ylabel('y');

saveas(gcf, "../img/parametric_2d.png");

%% Non-Parametric Estimation
v = 400;
cov = [400 0; 0 400];
parzen_mean = [v/2 v/2];
parzen_step = 1;

% parzen_res = 1;
% ksize = round(3*sqrt(v));
% kernel = -ksize:parzen_res:ksize;
% win = exp(-0.5.*kernel.*kernel/v);

lowx = min([min(a(:,1)), min(b(:,1)), min(c(:,1))]) - 1;
lowy = min([min(a(:,2)), min(b(:,2)), min(c(:,2))]) - 1;
highx = max([max(a(:,1)), max(b(:,1)), max(c(:,1))]) + 1;
highy = max([max(a(:,2)), max(b(:,2)), max(c(:,2))]) + 1;

parzen_res = [parzen_step lowx lowy highx highy];

[XP, YP] = meshgrid(1:parzen_step:v);
win = mvnpdf([XP(:) YP(:)], parzen_mean, cov);
win = reshape(win, length(YP), length(XP));

[prob_A, x_A, y_A] = parzen(a,parzen_res,win);
[prob_B, x_B, y_B] = parzen(b,parzen_res,win);
[prob_C, x_C, y_C] = parzen(c,parzen_res,win);

figure
plot(x_A, prob_A); hold on
plot(y_A, prob_A);

[X1,Y1] = meshgrid(x_A, y_A);
class_boundary_parzen = zeros(size(X1,1),size(Y1,2));
for i = 1:size(X1,1)
   for j = 1:size(Y1,2)
       [~, class] = max([prob_A(i,j), prob_B(i,j), prob_C(i,j)]);
       class_boundary_parzen(i,j) = class;
   end
end

figure();
hold on;

map = [1 0.75 0.8 %r
    0.82 0.94 0.75 %g
    0.68 0.85 0.9 %b 
    ];
colormap(map);
contourf(X1,Y1, class_boundary_parzen, 'Color','black');
scatter(a(:,1), a(:,2), 'r', 'filled');
scatter(b(:,1), b(:,2), 'g', 'filled'); 
scatter(c(:,1), c(:,2), 'b', 'filled');
hold off;
title("ML Classification");
xlabel('x');
ylabel('y');

saveas(gcf, "../img/nonparametric_2d.png");

close("all");