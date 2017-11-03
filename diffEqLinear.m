function [ stateDot ] = diffEqLinear( state,params,u )
    M = params(1); % masa wozka
    m = params(2); % masa wahadla
    L = params(3); % dlugosc od mocowania do srodka ciezkosci wahadla
    I = params(4); % moment bezwladnosci wahadla
    b = params(5); % wspolczynnik tarcia wozka
    g = params(6); % przyspieszenie ziemskie
    F = u(1); % sila przylozona do wozka

    A = [0, g * (M + m) / (M * L), b / (M * L), 0;
        1, 0, 0, 0;
        0, -g * m / M, -b / M, 0;
        0, 0, 1, 0];
    B = [-1/(M * L);
        0;
        1/M;
        0];
    stateDot = A * state + B * F;
end

