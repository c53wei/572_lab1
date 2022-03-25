clear
clc

data = matfile("lab_2_data/lab2_1.mat", "Writable", true);
a = sort(data.a)';
b = sort(data.b)';

[m, var] = estimate_gaussian(a);
pd = normpdf(a, 5, 1);
pd_ml = normpdf(a, m, sqrt(var));
figure();
hold on;
plot(a, pd, "k");
plot(a, pd_ml, "b");
hold off;
title("Gaussian Estimation of Data A")
xlabel("x");
ylabel("p(x)");
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "img/A_normal.png");

pd_ml = fitdist(a, "exponential");
pd_ml = pdf(pd_ml, a);
figure();
hold on;
plot(a, pd, "k");
plot(a, pd_ml, "b");
hold off;
title("Exponential Estimation of Data A")
xlabel("x");
ylabel("p(x)");
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "img/A_exp.png");


[m, var] = estimate_gaussian(b);
pd = exppdf(b, 1);
pd_ml = normpdf(b, m, sqrt(var));
figure();
hold on;
plot(b, pd, "k");
plot(b, pd_ml, "b");
hold off;
title("Gaussian Estimation of Data B")
xlabel("x");
ylabel("p(x)");
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "img/B_normal.png")

pd_ml = fitdist(b, "exponential");
pd_ml = pdf(pd_ml, b);
figure();
hold on;
plot(b, pd, "k");
plot(b, pd_ml, "b");
hold off;
title("Exponential Estimation of Data B")
xlabel("x");
ylabel("p(x)");
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "img/B_exp.png");



% close("all");