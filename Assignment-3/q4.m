clear;
close all;
clc;

n = 1000;
data = normrnd(0,4,1,n);
indices = randperm(n, 750);
T = data(indices);
remaining_indices = setdiff(1:n, indices);
V = data(remaining_indices);
% Define the values of sigma to be tested
sigma_values = [0.001, 0.1, 0.2, 0.9, 1, 2, 3, 5, 10, 20, 100];

% Initialize variables to store results
LL_values = zeros(size(sigma_values));
best_sigma = 0;
best_LL = -inf;

% Loop through different values of sigma
for i = 1:length(sigma_values)
    sigma = sigma_values(i);
    
    % Calculate the PDF estimate from T with the current sigma

    % Initialize the sum
    joint_likelihood = 0.0;
    
    % Perform the nested summation
    for k = 1:250
        density_sum = 0;
        for j = 1:750
            density_sum = density_sum + exp(-(T(j) - V(k))^2 / (2 * sigma^2)) / (750*sigma*sqrt(2*pi));
        end
        joint_likelihood = joint_likelihood + log(density_sum);
    end        
    % Store the log-likelihood value
    LL_values(i) = joint_likelihood;
    
    % Check if this sigma yielded the best LL value
    if joint_likelihood > best_LL
        best_sigma = sigma;
        best_LL = joint_likelihood;
    end
end

% Plot LL versus log(sigma)
figure;
log_sigma = log(sigma_values);
plot(log_sigma,LL_values);
xlabel('log(\sigma)');
ylabel('Log Joint Likelihood (LL)');
title('Cross-Validation for Bandwidth Parameter \sigma');
% Display and print the best sigma and corresponding LL value
fprintf('Best sigma: %f\n', best_sigma);
fprintf('Best LL value: %f\n', best_LL);

x = -8:0.1:8;
p_n = zeros(size(x));
p = normpdf(x,0,4);
for i = 1:length(x)
    for j = 1:750
        p_n(i) = p_n(i) + exp(-((x(i)-T(j))^2)/(2*(best_sigma)^2));
    end
    p_n(i) = p_n(i) / (750*best_sigma*sqrt(2*pi));
end

figure;
plot(x,p_n,'b',x,p,'r');
xlabel('x-values');
ylabel('PDF');
title('Kernel Density Estimation vs. True Density');


% 4(d) part
D_values = zeros(size(sigma_values));
best_D = +inf;
best_sigma_d = 0;
for i = 1:length(sigma_values)
    sigma = sigma_values(i);
    for k = 1:250
        p_x = 0;
        for j = 1:750
            p_x = p_x + exp(-((V(k)-T(j))^2)/(2*sigma^2))/(750*sigma*sqrt(2*pi));
        end
        D_values(i) = D_values(i) + (normpdf(V(k),0,4)-p_x)^2;
    end
    if(best_D>D_values(i))
        best_D = D_values(i);
        best_sigma_d = sigma;
    end
end

fprintf('Best sigma: %f\n', best_sigma_d);
fprintf('Best D: %f\n', best_D);

figure;
plot(log_sigma,D_values);

x = -8:0.1:8;
p_n = zeros(size(x));
p = normpdf(x,0,4);
for i = 1:length(x)
    for j = 1:750
        p_n(i) = p_n(i) + exp(-((x(i)-T(j))^2)/(2*(best_sigma_d)^2));
    end
    p_n(i) = p_n(i) / (750*best_sigma_d*sqrt(2*pi));
end

figure;
plot(x,p_n,'b',x,p,'r');
xlabel('x-values');
ylabel('PDF');
title('Kernel Density Estimation vs. True Density');
