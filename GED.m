function [ dist ] = GED( covar_a, mean_a, covar_b, mean_b, X, Y )
    dist = zeros(size(X, 1), size(Y, 2));
    get_dist = @(point, covar, mean) sqrt((point - mean) / (covar) * transpose(point - mean));

    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            v = [X(i, j) Y(i, j)];
            dist(i, j) = get_dist(v, covar_a, mean_a) - get_dist(v, covar_b, mean_b);
        end
    end
end
