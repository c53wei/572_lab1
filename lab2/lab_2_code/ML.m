function [classification] = ML(m_A,var_A,m_B,var_B,X,Y)
    classification = zeros(size(X,1), size(Y,2));

    for i = 1:size(X,1)
        for j = 1:size(Y,2)
            p = [X(i,j), Y(i,j)];
            disc_a = (p-m_A)*inv(var_A)*transpose(p-m_A);
            disc_b = (p-m_B)*inv(var_B)*transpose(p-m_B);
            classification(i,j) = disc_b-disc_a;
        end
    end
end