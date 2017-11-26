% pusty template s-funkcji
function [ sys,state0,str,ts ] = sFunction( t,state,u,flag )
    switch flag
        case 0 % inicjalizacja
            s = simsizes;
            s.NumContStates  = 0;  
            s.NumDiscStates  = 0;
            s.NumOutputs     = 0;   
            s.NumInputs      = 0;   
            s.DirFeedthrough = 0;
            s.NumSampleTimes = 1; 
            sys = simsizes(s);

            str = [];
            ts = [0 0];
            state0 = [];
        case 1 % rownania rozniczkowe
            sys = [];
        case 2 % rownania rozniczkowe
        case 3 % rownania wyjscia 
            sys = []; 
        case 4 % obliczanie kolejnej chwili czasu algorytmow zmiennokrokowych
            sys = [];
        case 9 % dzialania wykonywane na koniec symulacji
            sys = []; 
        otherwise
            error(['unhandled flag = ',num2str(flag)]);
    end
end