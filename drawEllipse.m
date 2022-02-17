function [x, y] = drawEllipse(m, covariance)

[V, ~] = eig(covariance);
V = V./norm(V);
e = eig(covariance);


% Get points of vertices 
% Get value and index of major axis
[max_lambda, max_I] = max(e);
major1 = m + sqrt(max_lambda).*V(:, max_I);
major2 = m - sqrt(max_lambda).*V(:, max_I);
% Get value of minor axis
min_lambda = min(e);
c = sqrt(max_lambda - min_lambda);
eccentricity = c/sqrt(max_lambda);
num_points = 300;
% Make equations:
x1 = major1(1);
x2 = major2(1);
y1 = major1(2);
y2 = major2(2);
a = (1/2) * sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2);
b = a * sqrt(1-eccentricity^2);
t = linspace(0, 2 * pi, num_points); % Absolute angle parameter
X = a * cos(t);
Y = b * sin(t);
% Compute angles relative to (x1, y1).
angles = atan2(y2 - y1, x2 - x1);
x = (x1 + x2) / 2 + X * cos(angles) - Y * sin(angles);
y = (y1 + y2) / 2 + X * sin(angles) + Y * cos(angles);
end