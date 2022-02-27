function [classification] = knn(class_a, class_b, k, X, Y)
    classification = zeros(size(X,1),size(Y,2));
    euclid = @(point, cluster) [cluster, sqrt(sum(bsxfun(@minus, cluster, point).^2,2))];

    for i = 1:size(X,1)
        for j = 1:size(Y,2)
            point = [X(i,j),Y(i,j)];
            distA = euclid(point,class_a);
            distB = euclid(point,class_b);
            minA = closest_dist(distA, k, point);
            minB = closest_dist(distB, k, point);
            classification(i,j) = minA - minB;
        end
    end

end


function [closest] = closest_dist(d,k,point)
    k_rows = sortrows(d, 3);
    k_rows = k_rows(1:k,:);
    k_rows(:,3) = [];
    closest_mean = mean(k_rows, 1);
    closest = sqrt((point-closest_mean)*(point-closest_mean)');
end