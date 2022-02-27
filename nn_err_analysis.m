function [confusionmat,p_err] = nn_err_analysis(varargin)

    if nargin==2
        class_a = varargin{1};
        class_b = varargin{2};
    
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

    elseif nargin==3
        class_c = varargin{1};
        class_d = varargin{2};
        class_e = varargin{3};
    
        n_c = 100;
        mu_c = [5, 10];
        covar_c = [8, 4; 4, 40];
        class_c2 =  repmat(mu_c, n_c, 1) + randn(n_c, 2)*chol(covar_c);
    
        n_d = 200; 
        mu_d = [15, 10];
        covar_d = [8, 0; 0, 8];
        class_d2 =  repmat(mu_d, n_d, 1) + randn(n_d, 2)*chol(covar_d);
    
        n_e = 150; 
        mu_e = [10, 5];
        covar_e = [10, -5; -5, 20];
        class_e2 =  repmat(mu_e, n_e, 1) + randn(n_e, 2)*chol(covar_e);

        NN_cd_class_c2 = knn_dist(class_c,class_d,1,class_c2);
        NN_de_class_c2 = knn_dist(class_d,class_e,1,class_c2);
        NN_ec_class_c2 = knn_dist(class_e,class_c,1,class_c2);

        NN_cd_class_d2 = knn_dist(class_c,class_d,1,class_d2);
        NN_de_class_d2 = knn_dist(class_d,class_e,1,class_d2);
        NN_ec_class_d2 = knn_dist(class_e,class_c,1,class_d2);

        NN_cd_class_e2 = knn_dist(class_c,class_d,1,class_e2);
        NN_de_class_e2 = knn_dist(class_d,class_e,1,class_e2);
        NN_ec_class_e2 = knn_dist(class_e,class_c,1,class_e2);

        % correctly classified points
        C = 0;
        D = 0;
        E = 0;

        % incorrectly classifed points, X_Y - classified as class X when should
        % be class Y
        D_C = 0;
        E_C = 0;

        C_D = 0;
        E_D = 0;

        C_E = 0;
        D_E = 0;

        for i = 1:length(class_c)
            predicted_class = which_class(NN_cd_class_c2(i), NN_de_class_c2(i), NN_ec_class_c2(i));
            if predicted_class == 1
                C = C + 1;
            elseif predicted_class == 2
                D_C = D_C + 1;
            elseif predicted_class == 3
                E_C = E_C + 1;
            end
        end

        for i = 1:length(class_d)
            predicted_class = which_class(NN_cd_class_d2(i), NN_de_class_d2(i), NN_ec_class_d2(i));
            if predicted_class == 1
                C_D = C_D + 1;
            elseif predicted_class == 2
                D = D + 1;
            elseif predicted_class == 3
                E_D = E_D + 1;
            end
        end

        for i = 1:length(class_e)
            predicted_class = which_class(NN_cd_class_e2(i), NN_de_class_e2(i), NN_ec_class_e2(i));
            if predicted_class == 1
                C_E = C_E + 1;
            elseif predicted_class == 2
                D_E = D_E + 1;
            elseif predicted_class == 3
                E = E + 1;
            end
        end

        p_err = 1 - ((C+D+E) / (n_c+n_d+n_e));
        
        confusionmat = [
            [C  D_C  E_C];
            [C_D  D  E_D];
            [C_E  D_E  E];
        ];

        else
    end

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

function [class] = which_class(cd, de, ec)
    if cd <= 0 && ec >= 0
        class = 1;
    elseif cd >= 0 && de <= 0
        class = 2;
    elseif de >= 0 && ec <= 0
        class = 3;
    else
    end
end