Pt = 10e3;
Pmin = 1e-13;
Gt = 1000;
Gr = 1000;
G = Gt;
c = 3e8;
lam = c/10e9;
Rmax = @(Pt, Gt, Gr, lam, s) (Pt .* Gt .* Gr .* lam.^2 .* s ./ ((4*pi)^3 * Pmin)).^(1/4);
R = linspace(0.1, 100, 500) * 1e3;
F = linspace(1, 20, 100);
S = linspace(0.1, 100, 100);

fprintf('Maximum Range = %.2f km\n', Rmax(Pt, Gt, Gr, lam, 1) / 1e3);
subplot(3,2,1), plot(R/1e3, 10*log10(Pt * Gt * Gr * lam^2 ./ ((4*pi)^3 * R.^4) / 1e-3)), grid on, title('Received Power vs Range'), xlabel('Range (km)'), ylabel('Power (dBm)')
subplot(3,2,2), plot(R/1e3, Pmin * (4*pi)^3 * R.^4 / (Gt * Gr * lam^2) / 1e3), grid on, title('Transmit Power vs Range'), xlabel('Range (km)'), ylabel('Power (kW)')
subplot(3,2,3), plot(R/1e3, 10*log10(Pmin * (4*pi)^3 * R.^4 / (Pt * Gr * lam^2))), grid on, title('Antenna Gain vs Range'), xlabel('Range (km)'), ylabel('Gain (dB)')
subplot(3,2,4), plot(F, Rmax(Pt, Gt, Gr, c ./ (F * 1e9), 1) / 1e3), grid on, title('Max Range vs Frequency'), xlabel('Frequency (GHz)'), ylabel('Max Range (km)')
subplot(3,2,5), plot(S, Rmax(Pt, Gt, Gr, lam, S) / 1e3), grid on, title('Max Range vs RCS'), xlabel('RCS (m^2)'), ylabel('Max Range (km)')
