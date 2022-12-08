clc
clear all
close all

nfig = 1;
q = 4;
A = 1;
N = 512;
f0 = 2400;
s = zeros(1, 65);
for a = 2 : 65
    s(a) = round(rand);
end

f = 0 : 100 : 100 * length(s);
T = 1/f(2);
dt = T / N;
t = 0 : dt: T - dt;
sqrtQ = sqrt(q);

phi1 = sqrt(2/T)*cos(2*pi*f0*t);
phi2 = -sqrt(2/T)*sin((2*pi*f0*t));
figure(nfig); nfig = nfig + 1;
modulator = zeros(length(s), N);
summ = zeros(1, N);
complex = zeros(1, N);
for i = 2 : length(s)
    if s(i) == 1
        modulator(i, :) = sin(2*pi*f(i)*t);
    end
    if s(i) == 0
        s(i) = -1;
        modulator(i, :) = -sin(2*pi*f(i)*t);
    end
    summ = summ + modulator(i, :);
    
    complex(1, i) = 0 + 1j * s(i);
end
subplot(4, 1, 1);
plot(modulator(2, :));
subplot(4, 1, 2);
plot(modulator(8, :));
subplot(4, 1, 3);
plot(modulator(20, :));
figure(nfig);
nfig = nfig + 1;
subplot(4, 1, 1);
plot(t, modulator(40, :));
subplot(4, 1, 2);
plot(modulator(50, :));
subplot(4, 1, 3);
plot(modulator(65, :));


figure(nfig); nfig = nfig + 1;
plot(t, summ);
grid on
title('Суммирование');

complex = complex .* -1;

furie = ifft(complex);

figure(nfig); nfig = nfig + 1;
plot(t, furie);
% plot(t, furie, '*');
grid on
title('После обратного преобразования');
