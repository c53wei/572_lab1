function [classified_A, classified_B, conf_matrix] = MED(a, b, mean_a, mean_b)
    classified_A = double.empty(0,2); % 2 columns
    classified_B = double.empty(0,2);

    trueA = 0;
    trueB = 0;
    falseB = 0;
    falseA = 0;

    for i=1:size(a,1)
        is_A = MED_is_A(mean_a, mean_b, a(i,:));
        if is_A
            trueA = trueA+1;
            classified_A = vertcat(classified_A, a(i,:));
        else
            falseB = falseB+1;
        end
    end

    for i=1:size(b,1)
        is_A = MED_is_A(mean_a, mean_b, b(i,:));
        if ~is_A
            trueB = trueB+1;
            classified_B = vertcat(classified_B, b(i,:));
        else
            falseA = falseA+1;
        end
    end

    conf_matrix = [trueA, falseB;
                    falseA, trueB];
end