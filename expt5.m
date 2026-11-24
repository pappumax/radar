c = 3e8; fc = 77e9; B = 150e6; Tchirp = 40e-6; Fs = 10e6;
N = 256; M = 128;                      
R = [20 50 80]; v = [5 10 -8]; A = [1 0.8 0.7];

lam = c / fc; S = B / Tchirp;          
t = (0:N-1) / Fs;
fb = (2 * S * R') / c;                 
fd = (2 * v') / lam;                   

rx = zeros(N, M);
for m = 1:M
    rx(:, m) = (A * exp(1j*2*pi*(fb*t + fd*m*Tchirp))).';
end

rng_fft = fft(rx, N, 1);               
RD = fftshift(fft(rng_fft, M, 2), 2);  
RD_dB = 20 * log10(abs(RD) + eps);

rng_axis = (0:N-1) * (c * Fs) / (2 * S * N);
vel_axis = ((-M/2 : M/2-1) / (M * Tchirp)) * (lam / 2);

figure;
imagesc(rng_axis, vel_axis, RD_dB.'); axis xy; colorbar; colormap jet;
xlabel('Range (m)'); ylabel('Velocity (m/s)'); title('2D Range-Doppler Map');
xlim([0 100]); ylim([-30 30]);