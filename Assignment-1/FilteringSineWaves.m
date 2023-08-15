function FilteringSineWaves(f)
    x = -3:0.02:3;
    
    % Getting the corresponding sin vector
    y = 6.5*sin(2.1*x + pi/3);

    % Getting random indices and corrupting them according to the question
    indices = randperm(numel(y),floor(numel(y)*f));
    random_numbers = 100 + 20 * rand(1,numel(indices));
    z = y;
    z(indices) = z(indices) + random_numbers;
    
    % Filtering using Median (Moving Median Filtering)
    y_med = z;
    for i = 1:numel(z)
        neighborhood_start = max(1, i - 8);        % For left-end start = 1
        neighborhood_end = min(numel(z), i + 8);   % For right-end end = numel(z)
        neighborhood = z(neighborhood_start:neighborhood_end);
        y_med(i) = median(neighborhood);
    end
    
    % Filtering using Arithmetic Mean (Moving Average Filtering)
    y_mean = z;
    for i = 1:numel(z)
        neighborhood_start = max(1, i - 8);        % For left-end start = 1
        neighborhood_end = min(numel(z), i + 8);   % For right-end end = numel(z)
        neighborhood = z(neighborhood_start:neighborhood_end);
        y_mean(i) =  mean(neighborhood);
    end
    
    % Filtering using the first quartile (Moving Quartile Filtering)
    y_quart = z;
    for i = 1:numel(z)
        neighborhood_start = max(1, i - 8);        % For left-end start = 1
        neighborhood_end = min(numel(z), i + 8);   % For right-end end = numel(z)
        neighborhood = z(neighborhood_start:neighborhood_end);
        y_quart(i) = quantile(neighborhood,0.25);
    end
    
    % Plotting all the different filtered arrays
    figure;
    plot(x,y,'b',x,z,'g',x,y_med,'r',x,y_mean,'m',x,y_quart,'k');
    xlabel('x-values');
    ylabel('Amplitude');
    title(['Filtering Sine Waves (f = ', num2str(f),')']);
    legend('Original','Corrupted','Moving Median Filter','Moving Average Filter','Moving Quartile Filter');
    
    % Calculating the different mean squared errors and printing them
    med_SME = sqrt(sum((y-y_med).^2) / sum(y.^2));
    mean_SME = sqrt(sum((y-y_mean).^2) / sum(y.^2));
    quart_SME = sqrt(sum((y-y_quart).^2) / sum(y.^2));
    disp(['For f = ', num2str(f) ,' we get,']);
    disp(['The relative mean squared error for Moving Median Filter is: ', num2str(med_SME)]);
    disp(['The relative mean squared error for Moving Average Filter is: ', num2str(mean_SME)]);
    disp(['The relative mean squared error for Moving Quartile Filter is: ', num2str(quart_SME)]);
end
