clc; clear; close all;
d = 36000; Latm = 2; Lmisc = 1;
T = 500; k = 1.380649e-23; Pr_req = -100; N0_dB = 10*log10(k*T);

[EIRP_u, LFS_u, Pr_u, CN0_u, LM_u] = linkCalc(20, 45, 35, 14, d, 2, 1, Latm, Lmisc, N0_dB, Pr_req);

fprintf('Metric   Uplink\n');
fprintf('EIRP    %8.2f\n', EIRP_u);
fprintf('LFS     %8.2f\n', LFS_u);
fprintf('Pr      %8.2f\n', Pr_u);
fprintf('C/N0    %8.2f\n', CN0_u);
fprintf('LM      %8.2f\n', LM_u);

dv = 1000:1000:50000;
Pr_v = EIRP_u + 35 - (92.45 + 20*log10(14) + 20*log10(dv) + 1 + Latm + Lmisc);
ev = 20:1:70;  lm1 = (ev + 35 - LFS_u - 1 - Latm - Lmisc) - Pr_req;
lv = 180:1:220; lm2 = (EIRP_u + 35 - lv - 1 - Latm - Lmisc) - Pr_req;
gv = 10:1:60;  lm3 = (EIRP_u + gv - LFS_u - 1 - Latm - Lmisc) - Pr_req;

subplot(2,2,1); plot(dv, Pr_v, 'b', 'LineWidth', 2); grid on; title('Uplink Pr vs Distance'); xlabel('d (km)'); ylabel('Pr (dBW)');
subplot(2,2,2); plot(ev, lm1,  'r', 'LineWidth', 2); grid on; title('Uplink LM vs EIRP'); xlabel('EIRP (dBW)'); ylabel('LM (dB)');
subplot(2,2,3); plot(lv, lm2,  'm', 'LineWidth', 2); grid on; title('Uplink LM vs LFS'); xlabel('LFS (dB)'); ylabel('LM (dB)');
subplot(2,2,4); plot(gv, lm3,  'g', 'LineWidth', 2); grid on; title('Uplink LM vs Gain'); xlabel('Gain (dBi)'); ylabel('LM (dB)');

function [EIRP, LFS, Pr, CN0, LM] = linkCalc(Pt, Gt, Gr, f, d, Ltx, Lrx, Latm, Lmisc, N0_dB, Pr_req)
    EIRP = Pt + Gt - Ltx;
    LFS  = 92.45 + 20*log10(f) + 20*log10(d);
    Pr   = EIRP + Gr - (LFS + Lrx + Latm + Lmisc);
    CN0  = Pr - N0_dB;
    LM   = Pr - Pr_req;
end