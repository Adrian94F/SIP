clearvars;

M = 0.5; % masa wozka
m = 0.2; % masa wahadla
L = 0.3; % dlugosc od mocowania do srodka ciezkosci wahadla
b = 0.1; % wspolczynnik tarcia wozka
g = 9.80665; % przyspieszenie ziemskie

A = [0, g * (M + m) / (M * L), b / (M * L), 0;
    1, 0, 0, 0;
    0, -g * m / M, -b / M, 0;
    0, 0, 1, 0];
B = [-1/(M * L);
    0;
    1/M;
    0];
C = [1 1 1 1];
D = 0;

% test obserwowalnosci
ob = obsv(A,C);
rank(ob)
% test sterowalnosci
ct = ctrb(A,B);
rank(ct)

% lqr
Q = diag([0 1000 0 100]);
R = 1;
K = lqr(A,B,Q,R);
disp(['K = [',num2str(K(1)),',',num2str(K(2)),',',num2str(K(3)),',',num2str(K(4)),'];']);