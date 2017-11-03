function [ sys,init,str,ts ] = objModel( t,state,u,flag,state0,params,modelSel)
    switch flag
        case 0
            s = simsizes;
            s.NumContStates  = 4;  
            s.NumDiscStates  = 0;
            s.NumOutputs     = 4;   
            s.NumInputs      = 1;   
            s.DirFeedthrough = 0;
            s.NumSampleTimes = 1; 
            sys = simsizes(s);

            str = [];
            ts = [0 0]; 
            init = state0;
        case 1      
            if (strcmp(modelSel,'full'))
                stateDot = diffEqFull(state,params,u);
            else
                stateDot = diffEqLinear(state,params,u);
            end
            
            sys = stateDot;
        case 3
            sys = state; % wyjsciem jest stan     
        case {2,4,9}
            sys = []; 
        otherwise
            error(['unhandled flag = ',num2str(flag)]);
    end
end

