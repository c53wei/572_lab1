
function[ dist ] = NN( k, class_a, class_b, X, Y )
    dist = zeros(size(X, 1), size(Y, 2));
    for i = 1:size(X, 1)
       for j = 1:size(Y, 2)
           point = [X(i,j), Y(i,j)];
           dist(i, j) = get_closest(point, class_a, k) - get_closest(point, class_b, k);
       end
    end
end

function [closest] = get_closest(point, samples, k)
    dist = zeros(size(samples,1),1);
    for i = 1:size(samples, 1)
        x = samples(i,:);
        dist(i,1) = sqrt( ( x(1,1) - point(1,1) )^2 + ( x(1,2) - point(1,2) )^2 ); 
    end    
    distanceMatrix = [dist, samples];
    distanceMatrix = sortrows(distanceMatrix);
    
    %if k ==1 , NN else its kNN
    distanceMatrix = distanceMatrix(1:k,:);
    distanceMatrix(:,1) = []; 
    closest_mean = mean(distanceMatrix, 1);
    closest = sqrt((point - closest_mean) * (point-closest_mean)'); %take the distance to the closest mean.
end


