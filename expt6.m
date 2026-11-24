r = 0:100;
th = linspace(0,2*pi,500);
R = [25 50 75 60];
Az = [40 120 220 300];
V = [0.15 -0.10 0.08 -0.12];
W = [0.4 -0.25 0.15 -0.3];
B = zeros(101,360);

figure
for ang = 1:360
   R = R + V*0.05;
   Az = mod(Az + W*0.05, 360);
   hit = abs(mod(Az - ang + 180, 360) - 180) <= 4;
   
   % A-scan
   a = 0.02*rand(size(r));
   for k = find(hit)
       a = a + exp(-((r - R(k))/2).^2);
   end
   subplot(1,3,1), plot(r, a), axis([0 100 0 1.2])
   
   % B-scan 
   B = 0.99*B;
   B(round(R(hit))+1, mod(round(Az(hit)),360)+1) = 1;
   ax2 = subplot(1,3,2);
   imagesc(0:359, r, B), axis xy, clim([0 1])
   colormap(ax2, [linspace(0.08, 1, 256)', linspace(0.08, 0.9, 256)', linspace(0.08, 0, 256)'])
   
   % PPI
   x = R.*sind(Az); y = R.*cosd(Az);
   subplot(1,3,3), plot(sin(th)'*(25:25:100), cos(th)'*(25:25:100), 'Color',[.7 .7 .7], 'LineWidth',0.5), hold on
   plot(x, y, 'bo', x(hit), y(hit), 'ro', [0 100*sind(ang)], [0 100*cosd(ang)], 'w'), hold off
   axis equal, axis([-100 100 -100 100])
   drawnow
end