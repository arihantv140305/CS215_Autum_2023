clear;
close all;
clc;

for n = [5 10 20 50 100 200 500 1000 5000 10000]
    nsamp = 5000;
    x = rand(nsamp, n);
    x(x < 0.05) = 1; x(x >= 0.05 & x < 0.45) = 2;x(x >= 0.45 & x<0.6) = 3;
    x(x >= 0.6 & x< 0.9) = 4; x(x>=0.9 & x<1) = 5;
    sumx = sum(x, 2)/n;
    ecdf(sumx)
    hold on;
    mu = mean(sumx);
    sigma = std(sumx);
    gvals = linspace(min(sumx), max(sumx), 1000);
    p = normcdf(gvals, mu, sigma);
    plot(gvals, p);
    title (sprintf('CDF of the average and gaussian n = %d',n));
    hold off;
    filename = sprintf('plot_n_%d.png', n);
    saveas(gcf, filename);
    pause(0.5);
end
