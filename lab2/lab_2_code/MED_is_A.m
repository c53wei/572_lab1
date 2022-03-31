function [is_A] = MED_is_A(prototype_A, prototype_B, point)
    dist = (prototype_A(1)-point(1)).^2 + (prototype_A(2)-point(2)).^2 - ((prototype_B(1)-point(1)).^2 + (prototype_B(2)-point(2)).^2);
    
    if dist < 0
        is_A = true;
    else
        is_A = false;
    end
end