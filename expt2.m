snr = [5 7.5 10 12.5];
T = linspace(0,6,50);
x = zeros(1,500);
x(100:150) = 1;

figure
for k = 1:4
   subplot(4,1,k); plot(awgn(x,snr(k),'measured')); hold on; plot(x,'r','LineWidth',1.5); grid on
   title("SNR = " + snr(k) + " dB"); xlabel('Sample'); ylabel('Amplitude')
   if k == 1, legend('Noisy', 'Clean'); end
end

for k = 1:4
   s = 10^(-snr(k)/20);
   Pfa(k,:) = mean(s*randn(1e4,1) > T);
   Pd(k,:) = mean(1 + s*randn(1e4,1) > T);
end

figure; plot(T,Pd,T,Pfa,'--'); grid on
xlabel('Threshold (T)'); ylabel('Probability'); title('Pd and Pfa vs Threshold')
legend(["Pd " + snr + " dB", "Pfa " + snr + " dB"])

figure; plot(Pfa',Pd','-o'); grid on
xlabel('Probability of False Alarm (Pfa)'); ylabel('Probability of Detection (Pd)'); title('ROC Curves')
legend("SNR = " + snr + " dB", 'Location', 'southeast')
