M = 0.5; % masa wozka
m = 0.2; % masa wahadla
L = 0.3; % dlugosc od mocowania do srodka ciezkosci wahadla
l = L;
I = 0.006; % moment bezwladnosci wahadla
b = 0.1; % wspolczynnik tarcia wozka
g = 9.80665; % przyspieszenie ziemskie    
A = [0, g * (M + m) / (M * L), b / (M * L), 0;
        1, 0, 0, 0;
        0, -g * m / M, -b / M, 0;
        0, 0, 1, 0];
B = [1/(M * L);
        0;
        -1/M;
        0];
C = [0 1 0 0];
D = 0;

s = tf('s');
[num,den] = ss2tf(A,B,C,D);
sys = tf(num,den);


rlocus((s+3)* (s+4)/s * sys)
sgrid(.6, 0)
