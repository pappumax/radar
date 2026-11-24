clc; clear; close all;

range = 0:0.1:100;
pulse = @(amp, pos, width) amp * exp(-((range - pos) / width).^2);

clutter = pulse(8, 20, 2.5) + pulse(6, 75, 3);
statTarget = pulse(7, 50, 1.2);
movTarget1 = pulse(7, 35, 1.2);
movTarget2 = pulse(7, 40, 1.2);

sweep1 = clutter + statTarget + movTarget1;
sweep2 = clutter + statTarget + movTarget2;
mtiOut = abs(sweep1 - sweep2);

figure('Name', 'MTI Radar: Clutter vs Stationary vs Moving', 'Color', 'k');
plotSweep(1, range, sweep1, 'b', 1.5, '1. Sweep 1: Clutter (20, 75 km), Stationary Target (50 km), Moving Target (35 km)');
plotSweep(2, range, sweep2, 'r', 1.5, '2. Sweep 2 (Delayed): Clutter & Stationary Target Unchanged, Moving Target Shifted to 40 km');
plotSweep(3, range, mtiOut, 'y', 1.8, '3. MTI Output: Clutter & Stationary Targets Cancelled (0 V), Only Moving Target Detected');

function plotSweep(idx, range, sig, color, width, titleText)
subplot(3, 1, idx);
plot(range, sig, color, 'LineWidth', width);
title(titleText);
xlabel('Distance / Range (km)');
ylabel('Amplitude (V)');
ylim([0, 10]);
grid on;
end
