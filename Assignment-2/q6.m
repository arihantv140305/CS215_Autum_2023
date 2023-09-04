clear;
close all;

im1 = double(imread('images/T1.jpg'));
im2 = double(imread('images/T2.jpg'));
shift = -10:10;

correlation_values = zeros(1, length(shift));
qmi_values = zeros(1, length(shift));

bin_width = 10;

for idx = 1:length(shift)
    tx = shift(idx);
    shifted_im2 = imtranslate(im2, [tx, 0]);
    
    pi1i2 = zeros(floor(256/bin_width) + 1, floor(256/bin_width)+1);
    
    for i = 1:size(im1, 1)
        for j = 1:size(im1, 2)
            x = floor(double(im1(i,j)) / bin_width) + 1;
            y = floor(double(shifted_im2(i,j)) / bin_width) + 1;
            pi1i2(x, y) = pi1i2(x,y) + 1;
        end
    end

    pi1 = sum(pi1i2, 2);
    pi2 = sum(pi1i2, 1);
    
    pi1i2 = pi1i2 / sum(pi1i2(:));
    pi1 = pi1 / sum(pi1(:));
    pi2 = pi2 / sum(pi2(:));
    
    mean_p1 = pi1 - mean(pi1);
    mean_p2 = pi2 - mean(pi2);
    
    corrmatrix = corrcoef(im1, shifted_im2);
    %display(corrmatrix);
    correlation_values(idx) = corrmatrix(1,2);
    qmi_values(idx) =  sum(sum( (pi1i2 - (pi1*pi2)) .^2 ));
end

figure;
subplot(2,2,1);
plot(shift, correlation_values);
xlabel('Shift (tx)');
ylabel('Correlation Coefficient (ρ)');
title('Correlation Coefficient vs. Shift');

% Plot the values of QMI versus tx
subplot(2,2,2);
plot(shift, qmi_values);
xlabel('Shift (tx)');
ylabel('Quadratic Mutual Information (QMI)');
title('QMI vs. Shift');

im2 = 255 - im1;

correlation_values = zeros(1, length(shift));
qmi_values = zeros(1, length(shift));

bin_width = 10;

for idx = 1:length(shift)
    tx = shift(idx);
    shifted_im2 = imtranslate(im2, [tx, 0]);
    
    pi1i2 = zeros(floor(256/bin_width) + 1, floor(256/bin_width)+1);
    
    for i = 1:size(im1, 1)
        for j = 1:size(im1, 2)
            x = floor(double(im1(i,j)) / bin_width) + 1;
            y = floor(double(shifted_im2(i,j)) / bin_width) + 1;
            pi1i2(x, y) = pi1i2(x,y) + 1;
        end
    end

    pi1 = sum(pi1i2, 2);
    pi2 = sum(pi1i2, 1);
    
    pi1i2 = pi1i2 / sum(pi1i2(:));
    pi1 = pi1 / sum(pi1(:));
    pi2 = pi2 / sum(pi2(:));
    
    mean_p1 = pi1 - mean(pi1);
    mean_p2 = pi2 - mean(pi2);
    
    corrmatrix = corrcoef(im1, shifted_im2);
    %display(corrmatrix);
    correlation_values(idx) = corrmatrix(1,2);
    qmi_values(idx) =  sum(sum( (pi1i2 - (pi1*pi2)) .^2 ));
end

subplot(2,2,3);
plot(shift, correlation_values);
xlabel('Shift (tx)');
ylabel('Correlation Coefficient (ρ)');
title('Correlation Coefficient vs. Shift for Inverted');

% Plot the values of QMI versus tx
subplot(2,2,4);
plot(shift, qmi_values);
xlabel('Shift (tx)');
ylabel('Quadratic Mutual Information (QMI) for Inverted');
title('QMI vs. Shift');

