clearvars;

% parametry symulacji
tSim = 10;
global h;
h = 0.01;
t = (0:h:tSim)';
tt = numel(t);
setTheta = [t,ones(tt,1) * 0];
setPos = [t,ones(tt,1) * 0];

% warunek poczatkowy i parametry
thetaDot0 = 0;
theta0 = 1/5 * pi;
xDot0 = 0;
x0 = 0;
state0 = [thetaDot0;theta0;xDot0;x0];  

% wybor modelu
modelSelect = 'linear';

for i = 1:100
M = 0.5; % masa wozka
m = 0.2; % masa wahadla
L = 0.3; % dlugosc od mocowania do srodka ciezkosci wahadla
I = 0.006; % moment bezwladnosci wahadla
b = 0.1; % wspolczynnik tarcia wozka
g = 9.80665; % przyspieszenie ziemskie
params = [M,m,L,I,b,g];

for j = 1:1000
% PID1
Kp1 = rand;
Ti1 = rand;
Td1 = rand;
% PID2
Kp2 = rand;
Ti2 = rand;
Td2 = rand;

sim('stabilizacja_pid_rownolegle.slx');
result = isStabilised(tSim, h, y);

end
end