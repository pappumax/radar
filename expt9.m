T = 150;
G = 35;
Pc = -100;
Tr = 50:10:500;
Gr = 20:50;
N = @(T) 10*log10(1.38e-23*T*1e6);

fprintf('Noise Power = %.2f dBW\n', N(T))
fprintf('C/N Ratio = %.2f dB\n', Pc - N(T))
fprintf('G/T Ratio = %.2f dB/K\n', G - 10*log10(T))
sgtitle('Link Budget & Noise Analysis')
subplot(2,2,1), plot(Tr, N(Tr), 'bo-', T, N(T), 'ro'), grid on; xlabel('Temperature (K)'), ylabel('Noise Power (dBW)'), title('Noise Power vs Temperature')
subplot(2,2,2), plot(Tr, Pc - N(Tr), 'bo-', T, Pc - N(T), 'ro'), grid on; xlabel('Temperature (K)'), ylabel('C/N (dB)'), title('C/N Ratio vs Temperature')
subplot(2,2,3), plot(Gr, Gr - 10*log10(T), 'bo-', G, G - 10*log10(T), 'ro'), grid on; xlabel('Gain (dB)'), ylabel('G/T (dB/K)'), title('G/T vs Gain')
subplot(2,2,4), plot(Tr, G - 10*log10(Tr), 'bo-', T, G - 10*log10(T), 'ro'), grid on; xlabel('Temperature (K)'), ylabel('G/T (dB/K)'), title('G/T vs Temperature')
