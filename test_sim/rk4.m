function [ newX ] = rk4( model,x,u)
    global h;
    k1 = h * model(x, u);
    k2 = h * model(x + 0.5 * k1, u);
    k3 = h * model(x + 0.5 * k2, u);
    k4 = h * model(x + k3, u);
    newX = x + 1 / 6 * (k1 + 2 * k2 + 2 * k3 + k4);
end

