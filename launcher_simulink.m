clearvars;

% parametry symulacji
tSim = 5;
global h;
h = 0.01;
t = (0:h:tSim)';
tt = numel(t);
setTheta = [t,ones(tt,1) * 0];
setPos = [t,ones(tt,1) * 0];

% warunek poczatkowy i parametry
thetaDot0 = 0;
theta0 = 1/20 * pi;
xDot0 = 0;
x0 = 0;
state0 = [thetaDot0;theta0;xDot0;x0];  
M = 0.5; % masa wozka
m = 0.2; % masa wahadla
L = 0.3; % dlugosc od mocowania do srodka ciezkosci wahadla
I = 0.006; % moment bezwladnosci wahadla
b = 0.1; % wspolczynnik tarcia wozka
g = 9.80665; % przyspieszenie ziemskie
params = [M,m,L,I,b,g];

% wybor modelu i regulatora
modelSelect = 'linear';
% PID1
Kp1 = -50.8;
Ti1 = 7.26;
Td1 = 0.24;
% PID2
Kp2 = 6;
Ti2 = inf;
Td2 = 1.5;
% LQR
K = [-6.6845,-51.6047,-9.6527,-10];
N = K(4);

% symulacja z simulinka
disp('Start symulacji...');
tic();
%sim('stabilizacja_pid_kaskada.slx');
%sim('stabilizacja_pid_rownolegle.slx');
sim('stabilizacja_lqr.slx');
disp('Koniec symulacji');
toc();

% wykresy
run plots;
run anims;