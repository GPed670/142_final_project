% Light Pollution Density Model (Modified Walker's Model)

% Constants
C = 372; % flux per person in kWh per year
d = 70;  % distance in km (constant as per Walker's Model)
conversion_factor = 1e6; % scale factor for visualization
s = 1; % scaling factor that changes for mitigation strategies

% modified model incorporating population density (D)
I = @(P, A) (s*(C ./ A) .* P .* (P ./ A)) .* d.^(-2.5);

% location data
locations = {'Los Angeles (Urban)', 'Oceanside (Suburban)', 'Bishop (Rural)', 'Death Valley (Protected)'};
pops = [3862210, 171400, 3851, 1124];  % Population
areas = [1213.85, 106.78521, 4.82, 12206.61]; % Area in km^2

num_locations = 4;
I_values = zeros(1, num_locations);

% calculate light pollution intensity for each location
for i = 1:num_locations
    P = pops(i);
    A = areas(i);
    I_values(i) = I(P, A);
    fprintf('Location: %s, Population Density: %.2f people/km^2\n', locations{i}, P/A);
end

% plot results
figure;
hold on;
colors = {'r', 'g', 'b', 'm'}; % color scheme
for i = 1:num_locations
    D_loc = pops(i) / areas(i); % calculate population density
    plot(D_loc, I_values(i), 'o', ...
         'MarkerSize', 10, 'MarkerFaceColor', colors{i}, 'DisplayName', locations{i});
end

xlabel('Population Density (people per km^2)');
ylabel('Log-scaled Sky Brightness');
title('Light Pollution Intensity');
set(gca, 'XScale', 'log'); % log scaling for density
ylim([0 1e5])
grid on;
legend('Location', 'northwest');

hold off;
