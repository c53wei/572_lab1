function dist = ComputeGED(x, mean, covariance)
    diff = x - mean;
    cov_inv = inv(covariance);
    dist = zeros(1, size(diff, 2));
    for i = 1:size(diff, 2)
        dist(i) = diff(:, i)'*cov_inv*diff(:, i);
    end
end
