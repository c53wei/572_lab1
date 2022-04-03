clear
clc

data = matfile("../lab_2_data/lab2_1.mat", "Writable", true);
a = sort(data.a)';
b = sort(data.b)';

%% Class A

% Gaussian Estimation
[m, var] = estimate_gaussian(a);
pd = normpdf(a, 5, 1);
pd_ml = normpdf(a, m, sqrt(var));
figure();
hold on;
plot(a, pd, "k", "LineWidth", 2);
plot(a, pd_ml, "b", "LineWidth", 2);
hold off;
title("Gaussian Distribution Estimation of Data A")
xlabel("x");
ylabel("p(x)");
xlim([0 10]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/A_normal.png");

% Exponential Estimation
% Note: mu = 1/lambda
pd_ml = makedist("Exponential", "mu", sum(a)/numel(a)); 
pd_ml = pdf(pd_ml, a);
figure();
hold on;
plot(a, pd, "k", "LineWidth", 2);
plot(a, pd_ml, "b", "LineWidth", 2);
hold off;
title("Exponential Distribution Estimation of Data A")
xlabel("x");
ylabel("p(x)");
xlim([0 10]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/A_exp.png");

% Uniform Estimation
pd_ml = makedist('Uniform','lower', a(1),'upper', a(numel(a)));
pd_ml = pdf(pd_ml, 0:.01:10);
figure();
hold on;
plot(a, pd, "k", "LineWidth", 2);
plot(0:.01:10, pd_ml, "b", "LineWidth", 2);
hold off;
title("Uniform Distribution Estimation of Data A")
xlabel("x");
ylabel("p(x)");
xlim([0 10]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/A_uniform.png");

% Parzen Estimation h = 0.1
[x, parzen] = parzen_1d(a, 0.1);
figure;
hold on;
plot(a, pd, "k", "LineWidth", 2);
plot(x, parzen, "b", "LineWidth", 2);
hold off;
title("Parzen Estimation of Data A with Window \sigma = 0.1")
xlabel("x");
ylabel("p(x)");
xlim([0 10]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/A_parzen_01.png");

% Parzen Estimation h = 0.4
[x, parzen] = parzen_1d(a, 0.4);
figure;
hold on;
plot(a, pd, "k", "LineWidth", 2);
plot(x, parzen, "b", "LineWidth", 2);
hold off;
title("Parzen Estimation of Data A with Window \sigma = 0.4")
xlabel("x");
ylabel("p(x)");
xlim([0 10]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/A_parzen_04.png");

%% Class B

% Gaussian Estimation
[m, var] = estimate_gaussian(b);
pd = exppdf(b, 1);
pd_ml = normpdf(b, m, sqrt(var));
figure();
hold on;
plot(b, pd, "k", "LineWidth", 2);
plot(b, pd_ml, "b", "LineWidth", 2);
hold off;
title("Gaussian Distribution Estimation of Data B")
xlabel("x");
ylabel("p(x)");
xlim([0 5]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/B_normal.png")

% Exponential Estimation
pd_ml = makedist("Exponential", "mu", sum(b)/numel(b)); 
pd_ml = pdf(pd_ml, b);
figure();
hold on;
plot(b, pd, "k", "LineWidth", 2);
plot(b, pd_ml, "b", "LineWidth", 2);
hold off;
title("Exponential Distribution Estimation of Data B")
xlabel("x");
ylabel("p(x)");
xlim([0 5]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/B_exp.png");

% Uniform Estimation
pd_ml = makedist('Uniform','lower', b(1),'upper', b(numel(b)));
pd_ml = pdf(pd_ml, 0:0.01:5);
figure();
hold on;
plot(b, pd, "k", "LineWidth", 2);
plot(0:0.01:5, pd_ml, "b", "LineWidth", 2);
hold off;
title("Uniform Distribution Estimation of Data B")
xlabel("x");
ylabel("p(x)");
xlim([0 5]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/B_uniform.png");

% Parzen Estimation h = 0.1
[x, parzen] = parzen_1d(b, 0.1);
figure;
hold on;
plot(b, pd, "k", "LineWidth", 2);
plot(x, parzen, "b", "LineWidth", 2);
hold off;
title("Parzen Estimation of Data B with Window \sigma = 0.1")
xlabel("x");
ylabel("p(x)");
xlim([0 5]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/B_parzen_01.png");

% Parzen Estimation h = 0.4
[x, parzen] = parzen_1d(b, 0.4);
figure;
hold on;
plot(b, pd, "k", "LineWidth", 2);
plot(x, parzen, "b", "LineWidth", 2);
hold off;
title("Parzen Estimation of Data B with Window \sigma = 0.4")
xlabel("x");
ylabel("p(x)");
xlim([0 5]);
ylim([0 1]);
legend("p(x)", "p($$\hat{x}$$)", "Interpreter", "Latex");
saveas(gcf, "../img/B_parzen_04.png");


close("all");