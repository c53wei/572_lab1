function [dist] = c2NN( k, class_a, class_b, class_c ,X, Y )
    
    NNab = NN(k, class_a, class_b, X, Y);
    NNbc = NN(k, class_b, class_c, X, Y);
    NNca = NN(k, class_c, class_a, X, Y);
    dist = zeros(size(X, 1), size(Y, 2));
    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            if NNab(i, j) >= 0 && NNbc(i, j) <= 0
                dist(i, j) = 2;
            elseif NNab(i, j) <= 0 && NNca(i, j) >= 0
                dist(i, j) = 1;
            elseif NNbc(i, j) >= 0 && NNca(i, j) <= 0
                dist(i, j) = 3;
            end
        end
    end
end