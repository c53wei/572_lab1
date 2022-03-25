clear
clc

data = matfile("lab_2_data/lab2_1.mat", "Writable", true);
a = sort(data.a);
b = sort(data.b);

[a_m, a_var] = estimate_gaussian(a);
pd_a = normpdf(a, 5, 1);
pd_a_ml = normpdf(a, a_m, sqrt(a_var));
figure();
hold on;
plot(a, pd_a, "k");
plot(a, pd_a_ml, "b");
hold off;
title("Gaussian Estimation of Data A")
xlabel("x");
ylabel("p(x)");
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "img/A_normal.png")


% close("all");