clear;
close all;
clc;
s = [5 10 20 50 100 200 500 1000 5000 10000];
M_array = []
for n = s
    nsamp = 5000;
    x = rand(nsamp, n);
    x(x < 0.05) = 1; x(x >= 0.05 & x < 0.45) = 2;x(x >= 0.45 & x<0.6) = 3;
    x(x >= 0.6 & x< 0.9) = 4; x(x>=0.9 & x<1) = 5;
    sumx = sum(x, 2)/n;
    [f, xvals] = ecdf(sumx);
    mu = mean(sumx);
    sigma = std(sumx);
    gvals = linspace(min(sumx), max(sumx), 1000);
    p = normcdf(gvals, mu, sigma);
    abs_values = zeros(size(gvals));
    for i = 1:length(gvals)
        [~, idx] = min(abs(xvals - gvals(i)));
        abs_values(i) = abs(f(idx) - p(i));
    end
    M_array = [M_array max(abs_values)];
end
plot(s, M_array, 'LineWidth', 2);
title (sprintf('MAD v/s N'));
filename = sprintf('MAD.png');
saveas(gcf, filename);