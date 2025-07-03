function [theta, L, beta_all, betaR_all, alpha_all, r, dr, h, dh, svel] = beta_h(ego_dir, ego_file)
% Numerical value of beta(h, f) as defined by Vagle 1990
% Computes beta(h) for multiple frequencies using ray theory.
% INPUTS:
%   ego_dir  - directory of input CSV
%   ego_file - CSV file with 'pressure','temperature','salinity' columns
% OUTPUTS:
%   theta, L, beta_all, betaR_all, alpha_all, r, dr, h, dh, svel

% --- Load profile ---
T = readtable(fullfile(ego_dir, ego_file));
pres = T.pressure;
temp = T.temperature;
sal  = T.salinity;

% --- Grids ---
dh = 1;
h = 1:dh:1000;     % depth (m)
dr = 1;
r = dr:dr:8000;    % horizontal distance (m)
dlayers = [20 50 100:100:1000];
[~, ilayers, ~] = intersect(h, dlayers);

% --- Interpolate to grid ---
Temp = interp1(pres, temp, h, 'linear', 'extrap');
Sal  = interp1(pres, sal,  h, 'linear', 'extrap');
c = gsw_sound_speed(Sal, Temp, h); % sound speed

% --- Plot input profiles ---
figure; plot(Temp, -h); grid on; xlabel('Temperature (^{\circ}C)'); title('Temperature Profile');
figure; plot(Sal, -h); grid on; xlabel('Salinity (PSU)'); title('Salinity Profile');
figure; plot(c, -h); grid on; xlabel('Sound Speed (m/s)'); title('Sound Speed Profile');

% --- Initialize ---
theta = zeros(length(ilayers), length(r));
L = NaN(length(ilayers), length(r));

% --- Parallel Loop with fzero ---
parfor il = 1:length(ilayers)
    ih = ilayers(il);
    local_theta = zeros(1, length(r));
    local_L = NaN(1, length(r));

    for ir = 1:length(r)
        try
            ray_eq = @(x) sum(dh ./ tan(acos(min((c(1:ih)/c(1)) .* cos(x), 0.999999)))) - r(ir);
            tmptheta = fzero(ray_eq, [eps, pi/2 - eps]);
            local_theta(ir) = tmptheta;
            local_L(ir) = dh * sum(1 ./ sqrt(1 - (c(1:ih) .* cos(tmptheta) ./ c(1)).^2));
        catch
            local_theta(ir) = 0;
            local_L(ir) = NaN;
            warning("Invalid theta at depth %d, r = %.1f m", h(ih), r(ir));
        end
    end

    theta(il, :) = local_theta;
    L(il, :) = local_L;
    disp(['depth ' num2str(h(ih)) ' m'])
    disp([num2str(sum(local_theta > 0)) ' / ' num2str(length(r)) ' good theta values'])
end

% --- Compute beta for each frequency ---
frequencies = [3.15, 8.0];
beta_all = zeros(length(ilayers), length(frequencies));
betaR_all = cell(1, length(frequencies));
alpha_all = zeros(length(ilayers), length(frequencies));

for fi = 1:length(frequencies)
    f_kHz = frequencies(fi);
    alpha = equ_att_son_garrison(f_kHz, h, Temp, Sal);
    alpha_grid = alpha(ilayers); % specific depths
    sin_theta2 = sin(theta).^2;
    L2 = L.^2;
    atten = exp(-alpha_grid' .* L);

    beta_all(:, fi) = -10 * log10(2 * sum(r .* dr .* sin_theta2 .* atten ./ L2, 2));
    tmpb = r .* sin_theta2 .* atten ./ L2;
    betaR_all{fi} = -10 * log10(2 * cumsum(tmpb, 2));
    alpha_all(:, fi) = alpha_grid;
end

% --- Save results to CSV ---
dlayer_depths = h(ilayers)';
output = table(dlayer_depths, beta_all(:, 1), beta_all(:, 2), ...
    'VariableNames', {'Depth_m', 'Beta_dB_f3150', 'Beta_dB_f8000'});
writetable(output, fullfile(ego_dir, 'beta_profile_output.csv'));

% --- Final plot ---
figure;
plot(10.^(beta_all(:, 1)/20), -dlayer_depths, 'LineWidth', 1.5); hold on;
plot(10.^(beta_all(:, 2)/20), -dlayer_depths, 'LineWidth', 1.5);
xlabel('10^{\beta/20}'); ylabel('Depth (m)');
title('Beta vs. Depth'); legend('3.15 kHz', '8.0 kHz'); grid on;

% --- Output sound speed profile ---
svel = c;
end
