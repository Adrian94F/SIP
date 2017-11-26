% glowny skrypt uruchamiajacy symulacje z uzyciem s-funkcji w Simulinku

clearvars;

% parametry symulacji
tSim = 5; % czas symulacji
global h; % globalny krok symulacji
h = 0.01;
t = (0:h:tSim)'; % wektor czasu
tt = numel(t); % ilosc iteracji
setTheta = [t,ones(tt,1) * 0]; % wektor wartosci zadanych kata wychylenia 
setPos = [t,ones(tt,1) * 0]; % wektor wartosci zadanych polozenia wozka

% warunek poczatkowy i parametry
thetaDot0 = 0;
theta0 = 1/20 * pi;
xDot0 = 0;
x0 = 0;
state0 = [thetaDot0;theta0;xDot0;x0]; % wektor stanu poczatkowego wahadla
M = 0.5; % masa wozka
m = 0.2; % masa wahadla
L = 0.3; % dlugosc od mocowania do srodka ciezkosci wahadla
I = 0.006; % moment bezwladnosci wahadla
b = 0.1; % wspolczynnik tarcia wozka
g = 9.80665; % przyspieszenie ziemskie
params = [M,m,L,I,b,g]; % wektor parametrow wahadla do s-funkcji

% wybor modelu i regulatora
modelSelect = 'linear'; % wybor rodzaju modelu: full / linear

% parametry regulatorow
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
% wybor modelu do symulacji
%sim('stabilizacja_pid_kaskada.slx');
sim('stabilizacja_pid_rownolegle.slx');
%sim('stabilizacja_lqr.slx');
disp('Koniec symulacji');
toc();

% wykresy
run plots;
run anims;