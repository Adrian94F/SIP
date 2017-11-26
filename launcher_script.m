% glowny skrypt uruchamiajacy symulacje wahadla z uzyciem prostych metod
% calkowania rownan rozniczkowych

clearvars;

% parametry symulacji
tSim = 10;
global h;
h = 0.01;
t = (0:h:tSim)';
tt = numel(t);
setTheta = [t,ones(tt,1) * 0];
setPos = [t,zeros(tt,1)];
disruption = [t,zeros(tt,1)];

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
modelSelect = 'full';

% zmienne do PIDa
lastE = 0;
sumE = 0;

% symulacja w skrypcie
y = zeros(4,tt);
u = zeros(1,tt);
diffs = zeros(4,tt);
tic();
for i = 1:tt  
    % obiekt
    if (i == 1)
        y(:,i) = state0;
    else
        diffs(:,i-1) = diffEqFull(y(:,i-1),params,u(i-1));
        %RK4
%         k1 = h * diffs(:,i-1);
%         k2 = h * diffEqFull(y(:,i-1) + 0.5 * k1,params,u(i-1));
%         k3 = h * diffEqFull(y(:,i-1) + 0.5 * k2,params,u(i-1));
%         k4 = h * diffEqFull(y(:,i-1) + k3,params,u(i-1));
%         y(:,i) = y(:,i-1) + 1 / 6 * (k1 + 2 * k2 + 2 * k3 + k4);

        % Euler
%         y(:,i) = y(:,i-1) + h * diffs(:,i-1);

        % Adams-Bashforth                
        if (i <= 5)
            k1 = h * diffs(:,i-1);
            k2 = h * diffEqFull(y(:,i-1) + 0.5 * k1,params,u(i-1));
            k3 = h * diffEqFull(y(:,i-1) + 0.5 * k2,params,u(i-1));
            k4 = h * diffEqFull(y(:,i-1) + k3,params,u(i-1));
            y(:,i) = y(:,i-1) + 1 / 6 * (k1 + 2 * k2 + 2 * k3 + k4);   
        else
            y(:,i) = y(:,i-1) + h/24 * (55 * diffs(:,i-1) - 59 * diffs(:,i-2) + 37 * diffs(:,i-3) - 9 * diffs(:,i-4));
        end
    end
    
    %regulator
    % LQR
    % u(i) = -[-10.4058,-118.3376,-15.1782,-10] * y(:,i) + y(2,i) + setPos(i,2);
    % PID - zle nastrojony ale warto sprawdzic co sie stanie
    % [u(i), sumE, lastE] = PID([0.1, 1000000, 7], sumE, lastE, 0.5 - y(4,i));
end
y = y';
toc();

% wykresy
run plots;
run anims;
