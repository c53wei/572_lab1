clear
clc

data = matfile("../lab_2_data/lab2_3.mat", "Writable", true);
a = data.a;
b = data.b;

step = 1;
x_domain = min([a(:,1);b(:,1)])-1:step:max([a(:,1);b(:,1)])+1;
y_range = min([a(:,2);b(:,2)])-1:step:max([a(:,2);b(:,2)])+1;
[X, Y] = meshgrid(x_domain, y_range);

[G1, err1] = sequential(X, Y, 0, a, b);
[G2, err2] = sequential(X, Y, 0, a, b);
[G3, err3] = sequential(X, Y, 0, a, b);

figure(1);
scatter(a(:,1), a(:,2), 'rx');
hold on;
scatter(b(:,1), b(:,2), 'bo');
hold on;
contour(X,Y,G1,'black');
title('First Sequential Classifier');
legend('Class A','Class B', 'Sequential Classifier');
xlabel('x');
ylabel('y');
hold off;

figure(2);
scatter(a(:,1), a(:,2), 'rx');
hold on;
scatter(b(:,1),b(:,2), 'bo');
hold on;
contour(X,Y,G2,'black');
title('Second Sequential Classifier');
legend('Class A','Class B', 'Sequential Classifier');
xlabel('x');
ylabel('y');
hold off;

figure(3);
scatter(a(:,1), a(:,2), 'rx');
hold on;
scatter(b(:,1), b(:,2), 'bo');
hold on;
contour(X,Y,G3,'black');
title('Third Sequential Classifier');
legend('Class A','Class B', 'Sequential Classifier');
xlabel('x');
ylabel('y');
hold off;

disp("Error for Sequential Classifier 1 (G1): " + err1 )
disp("Error for Sequential Classifier 2 (G2): " + err2 )
disp("Error for Sequential Classifier 3 (G3): " + err3 )

%Deliverable 3
minimumError = [];
maximumError = [];
averageError = [];
stdDeviation = [];

% For each value of J = 1, 2, . . . , 5, 
for j=1:5
    errorRates = [];

    for i=1:20 %learn a sequential classifier 20 times to calculate the following
        [G, err] = sequential(X, Y, j, a, b);
        errorRates = cat(2,errorRates, err);
    end
    averageError = cat(1,averageError, [j mean(errorRates)]); %average error rate
    minimumError = cat(1,minimumError, [j min(errorRates)]);  %minimum error rate
    maximumError = cat(1,maximumError, [j max(errorRates)]);  %maximum error rate
    stdDeviation = cat(1,stdDeviation, [j std(errorRates)]);  %standard deviation
end

figure(4)
subplot(4,1,1);
plot(averageError(:,1), averageError(:,2), 'o-','linewidth',2,'markersize',5,'markerfacecolor','r');
title('Average Error Rate');
xlabel('J');
ylabel('Error Rate');

subplot(4,1,2);
plot(minimumError(:,1), minimumError(:,2), 'o-','linewidth',2,'markersize',5,'markerfacecolor','r');
title('Min Error Rate');
xlabel('J');
ylabel('Error Rate');

subplot(4,1,3);
plot(maximumError(:,1), maximumError(:,2), 'o-','linewidth',2,'markersize',5,'markerfacecolor','r');
title('Max Error Rate');
xlabel('J');
ylabel('Error Rate');

subplot(4,1,4);
plot(stdDeviation(:,1), stdDeviation(:,2), 'o-','linewidth',2,'markersize',5,'markerfacecolor','r');
title('Standard Deviation of Errors');
xlabel('J');
ylabel('Error Rate');
