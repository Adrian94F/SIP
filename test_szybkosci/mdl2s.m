function [ sys,state0,str,ts ] = mdl2s( t,state,u,flag,y0 )
    switch flag
        case 0 % inicjalizacja
            s = simsizes;
            s.NumContStates  = 1;  
            s.NumDiscStates  = 0;
            s.NumOutputs     = 1;   
            s.NumInputs      = 1;   
            s.DirFeedthrough = 0;
            s.NumSampleTimes = 1; 
            sys = simsizes(s);

            str = [];
            ts = [0 0];
            state0 = y0;
        case 1 % rownania rozniczkowe
            sys = -1/2 * state + u;
        case 2 % rownania roznicowe
            sys = [];
        case 3 % rownania wyjscia 
            sys = state; 
        case 4 % obliczanie kolejnej chwili czasu algorytmow zmiennokrokowych
            sys = [];
        case 9 % dzialania wykonywane na koniec symulacji
            sys = []; 
        otherwise
            error(['unhandled flag = ',num2str(flag)]);
    end