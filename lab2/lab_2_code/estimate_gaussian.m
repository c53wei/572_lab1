function [m, v] = estimate_gaussian(data)
    m = mean(data);
    v = var(data, 1);
end