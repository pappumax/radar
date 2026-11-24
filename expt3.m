clc; clear; close all;

c = 3e8; fc = 10e9;
vel = [10 20 30 40 50];
dist = [50 100 200 500];

fdVel = (2 .* vel .* fc) ./ c;
drawPlot(vel, fdVel, 'Target Velocity (m/s)', 'Doppler Frequency (Hz)', 'Target Velocity vs Doppler Frequency', false);

opFreq = [2 5 10 15 20] * 1e9;
fdFreq = (2 * 30 .* opFreq) ./ c;
drawPlot(opFreq/1e9, fdFreq, 'Operating Frequency (GHz)', 'Doppler Frequency (Hz)', 'Operating Frequency vs Doppler Frequency', false);

relPow = 1 ./ dist.^4;
relPow = relPow ./ max(relPow);
drawPlot(dist, relPow, 'Target Distance (m)', 'Normalized Received Power', 'Effect of Target Distance on Received Power', true);

v = 30; R = 100; fcFft = 10e9;
fd = (2 * v * fcFft) / c;
fprintf('Target velocity = %.2f m/s\nTarget distance = %.2f m\nCarrier frequency = %.2f GHz\nDoppler frequency = %.2f Hz\n', v, R, fcFft/1e9, fd);

Fs = 100e3; T = 0.1; t = 0:1/Fs:T-1/Fs; N = length(t);
rxSig = exp(1j * 2 * pi * fd * t);
noiseVar = mean(abs(rxSig).^2) / 10^(15/10);
rxSig = rxSig + sqrt(noiseVar/2) .* (randn(size(rxSig)) + 1j * randn(size(rxSig)));

f = (-N/2:N/2-1) * (Fs / N);
P = abs(fftshift(fft(rxSig))).^2 / N;

figure;
subplot(2,1,1); plot(t, real(rxSig), 'b'); grid on;
xlabel('Time (s)'); ylabel('Amplitude'); title('Received Doppler Signal');

subplot(2,1,2); plot(f, 10*log10(P + eps), 'LineWidth', 1.5); grid on; hold on;
xline(fd, '--r', 'LineWidth', 2);
xlabel('Frequency (Hz)'); ylabel('Power (dB)'); title('Doppler Power Spectrum Using FFT');
xlim([-5000 5000]); legend('FFT Power Spectrum', sprintf('Expected f_D = %.0f Hz', fd));

[~, idx] = max(P);
detFd = abs(f(idx));
fprintf('\nExpected Doppler frequency = %.2f Hz\nDetected FFT frequency   = %.2f Hz\n', fd, detFd);

function drawPlot(x, y, xl, yl, ttl, isLog)
    figure;
    if isLog, semilogy(x, y, '-o', 'LineWidth', 2, 'MarkerSize', 7);
    else, plot(x, y, '-o', 'LineWidth', 2, 'MarkerSize', 7); end
    grid on; xlabel(xl); ylabel(yl); title(ttl);
end