clearvars;

% generowanie nastaw regulatora dla losowych parametrów œrodowiska
nOfGenParams = 1000;
randomValues = [rand(nOfGenParams, 4) zeros(nOfGenParams, 4)];
for i=1:nOfGenParams
    M = randomValues(i,1); % masa wozka
    m = randomValues(i,2); % masa wahadla
    L = randomValues(i,3); % dlugosc od mocowania do srodka ciezkosci wahadla
    b = randomValues(i,4); % wspolczynnik tarcia wozka
    K = strojenie_lqr(M,m,L,b); % nastawy do sterownika liniowo kwadratowego
    randomValues(i, 5:8) = K;
end

% TODO: uczenie sieci neuronowej na tej podstawie