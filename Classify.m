function classification = Classify(train, test, type)
% Compute distance & reshape
    switch type
        case 'MED'
            dist = arrayfun(@(z) vecnorm(test-z.Mean), train, ...
            'UniformOutput', false);
            dist = vertcat(dist{:});
            % Classify and return
            [~, classification] = min(dist);
            
        case 'MICD'
            dist = arrayfun(@(z) ComputeGED(test, z.Mean, z.Covariance), ...
                train, 'UniformOutput', false);
           
            dist = vertcat(dist{:});
            % Classify and return
            [~, classification] = min(dist);

        
        case 'MAP'
            total_n = sum([train.N]);
            % Calculate P(x|A)P(A)
            prob = arrayfun(@(z) (z.N/total_n)*Gauss2d(test, ...
                z.Mean, z.Covariance), train, 'UniformOutput', false);
            prob = vertcat(prob{:});
            % Classify and return
            [~, classification] = max(prob);

        otherwise
            disp(strcat('No implementation of', type, 'classifer'));
            return;
    end
end





