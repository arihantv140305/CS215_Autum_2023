clear;
close all;
clc;

for n = [5 10 20 50 100 200 500 1000 5000 10000]
    nsamp = 5000;
    x = rand(nsamp, n);
    x(x < 0.05) = 1; x(x >= 0.05 & x < 0.45) = 2;x(x >= 0.45 & x<0.6) = 3;
    x(x >= 0.6 & x< 0.9) = 4; x(x>=0.9 & x<1) = 5;
    sumx = sum(x, 2)/n;
    numbins = 50;
    histogram(sumx, numbins);
    title (sprintf('PDF of the average of %d iid random variables',n));
    fname = sprintf('%d.png',n);
    h = get (gca, 'children');
    saveas(h,fname);

end
