clearvars;

% % generowanie nastaw regulatora dla losowych parametrów œrodowiska

% sta³e
nOfGenParams = 100000;
a = 1;
b = 100;

% masa wózka i wahad³a z przedzia³u [a,b]
randomInput = (b-a).*rand(nOfGenParams,2) + a;
% L i b z przedzialu [0, 1]
randomInput = [randomInput, rand(nOfGenParams,2)];
randomOutput = zeros(nOfGenParams, 4);
for i=1:nOfGenParams
    M = randomInput(i,1); % masa wozka
    m = randomInput(i,2); % masa wahadla
    L = randomInput(i,3); % dlugosc od mocowania do srodka ciezkosci wahadla
    b = randomInput(i,4); % wspolczynnik tarcia wozka
    K = strojenie_lqr(M,m,L,b); % nastawy do sterownika liniowo kwadratowego
    randomOutput(i, 1:4) = K;
end

% generowanie sieci neuronowej
generate_neural_network_function(randomInput, randomOutput);


% parametry symulacji
tSim = 5; % czas symulacji
global h; % globalny krok symulacji
h = 0.01;
t = (0:h:tSim)'; % wektor czasu
tt = numel(t); % liczba iteracji
setTheta = [t,ones(tt,1) * 0]; % wektor wartosci zadanych kata wychylenia 
setPos = [t,ones(tt,1) * 0]; % wektor wartosci zadanych polozenia wozka

% warunek poczatkowy i parametry
thetaDot0 = 0;
theta0 = 1/20 * pi;
xDot0 = 0;
x0 = 0;
state0 = [thetaDot0;theta0;xDot0;x0]; % wektor stanu poczatkowego wahadla

% parametry œrodowiska
M = (b-a).*rand() + a; % masa wozka
m = (b-a).*rand() + a; % masa wahadla
L = rand(); % dlugosc od mocowania do srodka ciezkosci wahadla
I = 1/3 * m * L^2; % moment bezwladnosci wahadla
b = rand(); % wspolczynnik tarcia wozka
g = 9.80665; % przyspieszenie ziemskie

params = [M,m,L,I,b,g]; % wektor parametrow wahadla do s-funkcji
% wybor modelu i regulatora
modelSelect = 'linear'; % wybor rodzaju modelu: full / linear

% parametry regulatorow
% LQR
K = lqr_neural_network([M m L b]')';
N = K(4);
% symulacja z simulinka
sim('stabilizacja_lqr.slx');
% wykresy
run plots;
run anims;