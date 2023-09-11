p = []
for n = 1:1000
    x = [1:n];
    one = ones(1, n);
    x = one./x;
    p = [p, n*sum(x)];
end; 
figure;
plot(p, 'r');
title('$n\sum_{i = 1}^n\frac{1}{i}$ v/s $n$', 'Interpreter', 'latex');
saveas(gcf, 'q1.png');

