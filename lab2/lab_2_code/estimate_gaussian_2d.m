function [m, v] = estimate_gaussian_2d(data)
    m = mean(data);
    v = cov(data);
end