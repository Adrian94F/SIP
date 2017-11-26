M = 0.5; % masa wozka
m = 0.2; % masa wahadla
b = 0.1; % wspolczynnik tarcia wozka

M = m + M;
s = tf('s');
K = 1 / (M * s^2 + b * s);

Kp = 0.8;
Td = 7;
R = Kp * (1 + Td * s);

step(R * K / (1 + R * K));