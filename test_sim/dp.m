function [ newX ] = dp( fcn,x,u )
    global h;
    dp = [0,0,0,0,0,0,0;
            1/5,0,0,0,0,0,0;
            3/40,9/40,0,0,0,0,0;
            44/45,-56/15,32/9,0,0,0,0;
            19372/6561,-25360/2187,64448/6561,-212/729,0,0,0;
            9017/3168,-355/33,46732/5247,49/176,-5103/18656,0,0;
            35/384,0,500/1113,125/192,-2187/6784,11/84,0];
    k = zeros(7,1);
    for i = 1:7
        k(i) = h * fcn(x + dp(i,:) * k,u);
    end
    newX = x + dp(7,:) * k;
end

