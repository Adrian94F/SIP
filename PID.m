% prosta implementacja PIDa
% params - wektor parametrow - K, Ti, Td
% sumE - suma wszystkich uchybow (do calki)
% lastE - ostatnia wartosc uchybu (do rozniczki)
% e - aktualna wartosc uchybu
function [ u,sumE,lastE ] = PID( params,sumE,lastE,e )
    global h;
    kp = params(1);
    ti = params(2);
    td = params(3);
    P = kp * e;
    sumE = sumE + e;
    I = kp * h / ti * sumE;
    D = kp * td * (e - lastE) / h;
    u = P + I + D;
    lastE = e;
end

