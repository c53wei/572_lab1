function [classified_A, classified_B, conf_matrix] = MED(a, b, mean_a, mean_b)
    classified_A = double.empty(0,2); % 2 columns
    classified_B = double.empty(0,2);

    trueA = 0;
    trueB = 0;
    falseB = 0;
    falseA = 0;

    for i=1:size(a,1)
        dist = (a(i,:)-mean_a)*transpose(a(i,:)-mean_a) - (a(i,:)-mean_b)*transpose(a(i,:)-mean_b);
        if dist < 0
            trueA = trueA+1;
            classified_A = vertcat(classified_A, a(i,:));
        else
            falseB = falseB+1;
        end
    end

    for i=1:size(b,1)
        dist = (b(i,:)-mean_a)*transpose(b(i,:)-mean_a) - (b(i,:)-mean_b)*transpose(b(i,:)-mean_b);
        if dist < 0
            falseA = falseA+1;
        else
            trueB = trueB+1;
            classified_B = vertcat(classified_B, b(i,:));
        end
    end

    conf_matrix = [trueA, falseB;
                    falseA, trueB];
end
