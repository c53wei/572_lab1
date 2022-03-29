function [x, p] = parzen_1d(data, h)

    x = 0:0.01:max(data);
    N = length(data);
    p = zeros(size(x));
    
    normal = @(t, mu) 1/sqrt(2*pi)*exp(-1/2*((t-mu)/h).^2);

    for i = 1:length(x)
        x_temp = zeros(size(data)) + x(i);
        p(i) = 1/(N*h)*sum(normal(x_temp, data));
    end

%     plot(x, p);
end