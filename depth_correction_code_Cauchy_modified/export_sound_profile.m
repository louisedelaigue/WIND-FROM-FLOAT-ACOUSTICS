%% export_sound_speed_profile.m
% Standalone script to export a sound speed profile (and interpolated T/S)
% from an input CSV with columns: pressure, temperature, salinity.
%
% OUTPUT: sound_speed_profile.csv in the same folder as the input file.

clear; clc;

%% --- User settings ---
ego_dir  = "/Users/ldelaigue/Documents/Github/WIND-FROM-FLOAT-ACOUSTICS/depth_correction_code_Cauchy_modified";  
ego_file = "interp_profile.csv";      

% Depth grid settings (meters)
dh = 1;                     % depth step
h_min = 1;                  % min depth
h_max = 1000;               % max depth
h = (h_min:dh:h_max).';     % column vector

% (Optional) path to GSW toolbox if not already on path:
% addpath('path/to/GSW-Matlab');

%% --- Load input table ---
T = readtable(fullfile(ego_dir, ego_file));

% Basic column checks
requiredVars = {'pressure','temperature','salinity'};
if ~all(ismember(requiredVars, lower(string(T.Properties.VariableNames))))
    error('Input CSV must have columns: pressure, temperature, salinity (case-insensitive).');
end

% Normalize column names to lower for safety
T.Properties.VariableNames = lower(T.Properties.VariableNames);

% Extract and ensure column vectors
pres = T.pressure(:);
temp = T.temperature(:);
sal  = T.salinity(:);

% Sort by increasing pressure if needed
[pres, sortIdx] = sort(pres, 'ascend');
temp = temp(sortIdx);
sal  = sal(sortIdx);

%% --- Interpolate to depth grid ---
% Here we assume 'pressure' is in dbar and approximately equals depth (m).
% If your pressure is *not* dbar ≈ depth, replace 'h' with your true depth.
Temp = interp1(pres, temp, h, 'linear', 'extrap');
Sal  = interp1(pres, sal,  h, 'linear', 'extrap');

%% --- Compute sound speed ---
% gsw_sound_speed(SA, t, p): SA=Absolute Salinity (g/kg), t=in-situ temp (°C), p=pressure (dbar)
% If your 'salinity' is Practical Salinity (PSU), GSW recommends converting to SA.
% Many ocean acoustics workflows approximate SA ≈ SP; we follow your original code.
if exist('gsw_sound_speed', 'file') ~= 2
    error(['gsw_sound_speed not found. Make sure the GSW toolbox is on the MATLAB path.' newline ...
           'Get it from: https://www.teos-10.org/software.htm']);
end

c = gsw_sound_speed(Sal, Temp, h); % m/s

%% --- Write CSV ---
outTbl = table( ...
    h, c, Temp, Sal, ...
    'VariableNames', {'Depth_m','SoundSpeed_mps','Temperature_degC','Salinity_PSU'});

outPath = fullfile(ego_dir, 'sound_speed_profile.csv');
writetable(outTbl, outPath);

fprintf('Wrote sound speed profile to:\n  %s\n', outPath);

%% --- (Optional) Quick plots ---
try
    figure('Name','Profiles','Color','w');

    subplot(1,3,1);
    plot(Temp, -h, 'LineWidth', 1.2); grid on;
    xlabel('Temperature (^{\circ}C)'); ylabel('Depth (m)');
    title('Temperature');

    subplot(1,3,2);
    plot(Sal, -h, 'LineWidth', 1.2); grid on;
    xlabel('Salinity (PSU)'); title('Salinity');

    subplot(1,3,3);
    plot(c, -h, 'LineWidth', 1.4); grid on;
    xlabel('Sound Speed (m/s)'); title('Sound Speed');

catch ME
    warning('Plotting skipped: %s', ME.message);
end
