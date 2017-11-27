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
M = 0.5; % masa wozka
m = 0.2; % masa wahadla
L = 0.3; % dlugosc od mocowania do srodka ciezkosci wahadla
I = 0.006; % moment bezwladnosci wahadla
b = 0.1; % wspolczynnik tarcia wozka
g = 9.80665; % przyspieszenie ziemskie
params = [M,m,L,I,b,g];
% wybor modelu
modelSelect = 'linear';
numberOfTests = 10;

% generowanie randomowych nastaw PIDów
randomPidSets = [rand(numberOfTests,5)]; %; [-50.8 7.26 0.24 6 inf 1.5]];

% klasyfikacja wyników
results = [ ];

for row=1:size(randomPidSets,1)
    % clearvars -except results randomPidSets modelSelect params state0 setTheta setPos row tSim h tt
    % PID1
    Kp1 = randomPidSets(row,1);
    Ti1 = randomPidSets(row,2);
    Td1 = randomPidSets(row,3);
    % PID2
    Kp2 = randomPidSets(row,4);
    Ti2 = inf;
    Td2 = randomPidSets(row,5);
    % symulacja
    sim('stabilizacja_pid_rownolegle.slx');
    % run plots;
    % run anims;
    results = [results isStabilised(tSim, h, y)];
end
