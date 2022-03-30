function [discriminant, error] = sequential_classifier(a,b,X,Y)
    orig_a = a;
    orig_b = b;
    
    na = 0;
    nb = 0;
    
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
        naB = conf_matrix(1,2);
        nbA = conf_matrix(2,1);
 
        if naB == 0
            prototypes_B = setxor(prototypes_B, classified_B, 'rows');
        end
            
        if nbA == 0
            prototypes_A = setxor(prototypes_A, classified_A, 'rows');
        end
 
        if(size(a, 1) == 0 || size(b,1) == 0)
            % stop
            break;
        end
    end
 
    discriminant = zeroes(size(X));
    for count = 1:size(orig_a,1)
        x_test = orig_a(k,:);
        for i = 1:j
            correct_a = MED_true_or_false(prototypes_A(i,:), prototypes_B(i,:), x_test);
            if correct_a
                na = na + 1;
                break
            end
        end
    end
    
    for count = 1:size(orig_b,1)
        x_test = orig_b(k,:);
        for i = i:j
            correct_a = MED_true_or_false(prototypes_A(i,:), prototypes_B(i,:), x_test);
            if ~correct_a
                nb = nb + 1;
                break
            end
        end
    end
    
    error = 1 - (na+nb)/400;
    
    end
 
function [class_A] = MED_true_or_false(prototypeA, prototypeB, x)
    dist_A = sqrt((prototypeA(1)-x(1)).^2 + (prototypeA(2)-x(2)).^2);
    dist_B = sqrt((prototypeB(1)-x(1)).^2 + (prototypeB(2)-x(2)).^2);
    
    if dist_A < dist_B
        class_A = true;
    else
        class_A = false;
    end
end
