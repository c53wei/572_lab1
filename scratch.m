classes = [class_c class_d class_e];
num_points = 100;
max_data = max([classes.Range], [], 2);
min_data = min([classes.Range], [], 2);
x1 = linspace(min_data(1), max_data(1), num_points);
x2 = linspace(min_data(2), max_data(2), num_points);
[A,B] = meshgrid(x1,x2);
c=cat(2,A',B');
x=reshape(c,[],2)';

total_n = sum([classes.N]);
% Calculate P(x|A)P(A)
prob = arrayfun(@(z) (z.N/total_n)*Gauss2d(x, ...
    z.Mean, z.Covariance), classes, 'UniformOutput', false);
prob = vertcat(prob{:});
% Classify and return
[win, classification] = max(prob);


figure;
hold on;
surf(x1, x2, reshape(win, size(A))');

xlabel('x1');
ylabel('x2');
zlabel('p(x_1, x_2');
set(gca, 'YDir', 'normal');
colormap('jet');
saveas(gcf, "img/scratch_c_d_e.png");