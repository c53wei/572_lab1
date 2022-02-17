function X = generateData(N, mean, covariance)
% Generate bivariate normal distributions
X = rand(N, 2);
% Box-Muller Transform
Z1 = sqrt(-2*log(X(:, 1))).*cos(2*pi*X(:, 2));
Z2 = sqrt(-2*log(X(:, 1))).*sin(2*pi*X(:, 2));
X = [Z1 Z2];

X = [X*chol(covariance)]' + mean;
end



