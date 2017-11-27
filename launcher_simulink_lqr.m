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
nOfGenParams = 5;
randomParams = [rand(nOfGenParams, 4)];
results = [];
for i=1:nOfGenParams
    % M = 0.5; % masa wozka
    % m = 0.2; % masa wahadla
    % L = 0.3; % dlugosc od mocowania do srodka ciezkosci wahadla
    % I = 0.006; % moment bezwladnosci wahadla
    b = 0.1; % wspolczynnik tarcia wozka
    g = 9.80665; % przyspieszenie ziemskie
    M = randomParams(i,1);
    m = randomParams(i,2);
    L = randomParams(i,3);
    I = randomParams(i,4);
    params = [M,m,L,I,b,g]; % wektor parametrow wahadla do s-funkcji
    % wybor modelu i regulatora
    modelSelect = 'linear'; % wybor rodzaju modelu: full / linear

    % parametry regulatorow
    % LQR
    K = strojenie_lqr(M,m,L,b);
    %K = [-6.6845,-51.6047,-9.6527,-10];
    N = K(4);

    % symulacja z simulinka
    disp('Start symulacji...');
    tic();
    % wybor modelu do symulacji
    sim('stabilizacja_lqr.slx');
    disp('Koniec symulacji');
    toc();
    results = [results isStabilised(tSim, h, y)];
    % wykresy
    % run plots;
    % run anims;
end