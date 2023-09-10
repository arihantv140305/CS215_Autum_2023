clear;
clc;
data = dlmread('XYZ.txt');
x = data(:,1);
y = data(:,2);
z = data(:,3);

A = [sum(x.*x), sum(x.*y), sum(x); sum(x.*y), sum(y.*y), sum(y); sum(x), sum(y), 1];
C = [sum(x.*z);sum(y.*z);sum(z)];
X = A\C;
fprintf("z = %fx + %fy +(%f)\n", X(1), X(2), X(3));
Z_predicted = X(1)*x + X(2)*y + X(3);
noise = z - Z_predicted;
fprintf('The noise variance is %f\n', var(noise));
