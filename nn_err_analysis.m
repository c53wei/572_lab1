function [confusionmat,p_err] = nn_err_analysis(class_a, class_b)
    n_a = 200;
    mu_a = [5, 10];
    covar_a = [8, 0; 0, 4];
    class_a2 =  repmat(mu_a, n_a, 1) + randn(n_a, 2)*chol(covar_a);
    
    n_b = 200; 
    mu_b = [10, 15];
    covar_b = [8, 0; 0, 4];
    class_b2 =  repmat(mu_b, n_b, 1) + randn(n_b, 2)*chol(covar_b);
    
    [T_a,F_a] = get_err(n_a, knn_dist(class_a,class_b,1,class_a2), @(y) y<0);
    [T_b,F_b] = get_err(n_b, knn_dist(class_a,class_b,1,class_b2), @(y) y>0);

    p_err = (F_a+F_b)/(n_a+n_b);

    confusionmat = [[T_a,F_b]; [F_a,T_b]];

end



function [dist] = knn_dist(class_a, class_b, k, X)

    dist = zeros(length(X), 1);
    euclid = @(point, cluster) [cluster, sqrt(sum(bsxfun(@minus, cluster, point).^2,2))];
    
    for i=1:length(X)
        point = X(i,:);
        distA = euclid(point,class_a);
        distB = euclid(point,class_b);
        minA = closest_dist(distA, k, point);
        minB = closest_dist(distB, k, point);
        dist(i) = minA - minB;
    end
end

function [T,F] = get_err(n, dist, fun)
    T = 0;
    for i=1:length(dist)
        point = dist(i);
        if fun(point)
            T = T + 1;
        end
    end
    F = n - T;
end

function [closest] = closest_dist(d,k,point)
    k_rows = sortrows(d, 3);
    k_rows = k_rows(1:k,:);
    k_rows(:,3) = [];
    closest_mean = mean(k_rows, 1);
    closest = sqrt((point-closest_mean)*(point-closest_mean)');
end