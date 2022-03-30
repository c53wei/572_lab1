function [discriminant, error] = sequential_classifier(a,b,X,Y)
    orig_a = a;
    orig_b = b;
    
    j = 1;
    prototypes_A = double.empty(0,2);
    prototypes_B = double.empty(0,2);

    while true
        prototype_A = a(randi(size(a,1)),:);
        prototype_B = b(randi(size(b,1)),:);
        
        [classified_A, classified_B, conf_matrix] = MED(a, b, prototype_A,prototype_B);
        
        if conf_matrix(1,2) ~= 0 || conf_matrix(2,1) ~= 0
            continue;
        end
        
        prototypes_A = vertcat(prototypes_A, prototype_A);
        prototypes_B = vertcat(prototypes_B, prototype_B);

        if conf_matrix(1,2) == 0
            % remove the true Bs from b
        end
            
        if conf_matrix(2,1) == 0
            % remove true As from a
        end

        if(size(a, 1) == 0 || size(b,1) == 0)
            % stop
            break;
        end
    end

    discriminant = zeroes(size(X));

    
end