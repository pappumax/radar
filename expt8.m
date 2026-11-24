alt = [500 20200 35786];
inc_deg = [51.6 55 0];
c = input('Press: 1-LEO, 2-MEO, 3-GEO: ');
r = 6371 + alt(c);
inc = deg2rad(inc_deg(c));
mu = 398600.4418;
T = 2*pi*sqrt(r^3/mu);
fprintf('Altitude = %d km\nPeriod = %.2f hours\n', alt(c), T/3600)

th = linspace(0, 2*pi, 500);
x = r*cos(th);
y = r*sin(th)*cos(inc);
z = r*sin(th)*sin(inc);
figure
[a, b, d] = sphere(50);
surf(6371*a, 6371*b, 6371*d, 'EdgeColor', 'none'), hold on, axis equal
sat = plot3(x(1), y(1), z(1), 'ro', 'MarkerFaceColor', 'r');
plot3(x, y, z, 'r')
for k = 1:5:500
    set(sat, 'XData', x(k), 'YData', y(k), 'ZData', z(k))
    drawnow
end

we = 2*pi / 86164.1;
t = linspace(0, 86400, 5000);
n = sqrt(mu / r^3);
u = n * t;

lat = asin(sin(inc) * sin(u)) * 180/pi;
lon_inertial = atan2(cos(inc) * sin(u), cos(u));
lon = mod((lon_inertial - we*t) * 180/pi + 180, 360) - 180;

wrap_idx = find(abs(diff(lon)) > 180);
lon_plot = lon;
lat_plot = lat;
lon_plot(wrap_idx + 1) = NaN;
lat_plot(wrap_idx + 1) = NaN;

figure
plot(lon_plot, lat_plot, 'b', 'LineWidth', 1.5), hold on
plot(lon(1), lat(1), 'ro', 'MarkerFaceColor', 'r')
xlim([-180 180])
ylim([-90 90])
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
title(sprintf('24-Hour Ground Track (Option %d: %d km)', c, alt(c)))
grid on