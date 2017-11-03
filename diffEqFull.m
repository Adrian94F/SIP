function [ stateDot ] = diffEqFull( state,params,u )
    M = params(1); % masa wozka
    m = params(2); % masa wahadla
    L = params(3); % dlugosc od mocowania do srodka ciezkosci wahadla
    I = params(4); % moment bezwladnosci wahadla
    b = params(5); % wspolczynnik tarcia wozka
    g = params(6); % przyspieszenie ziemskie
    F = u(1); % sila przylozona do wozka
    
    thetaDot = state(1);
    theta = state(2);
    xDot = state(3);
    x = state(4);

    stateDot = zeros(4,1);
    
    sTheta = sin(theta);
    cTheta = cos(theta);

    q = m^2 * L^2 * cTheta^2 - (I + m * L^2) * (M + m);
    stateDot(1) = (F * m * L * cTheta - b * m * L * cTheta * xDot - (M + m) * m * L * g * sTheta + m^2 * L^2 * sTheta * cTheta * thetaDot^2) / q;
    stateDot(2) = thetaDot;
    stateDot(3) = ((I + m * L^2) * (-F + b * xDot - m * L * sTheta * thetaDot^2) + m^2 * L^2 * g * sTheta * cTheta) / q;
    stateDot(4) = xDot;
end

