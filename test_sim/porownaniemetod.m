% porownanie metod calkowania Euler vs RK4 dla rownania rozniczkowego bez
% wejsc i innych y' = f(y,t)

h = 0.001;
dt = 0.1;
t = 0:h:3;
y = exp(sin(t));
tt = 0:dt:3;
ttt = numel(tt);

y1 = zeros(1,ttt);
y2 = zeros(1,ttt);

fcn = @(t,y)(y * cos(t));

y1(1) = y(1);
y2(1) = y(1);
for i = 2:ttt
    % euler
    y1(i) = y1(i-1) + dt * fcn(tt(i-1),y1(i-1));
    
    % rk4
    k1 = dt * fcn(tt(i-1),y2(i-1));
    k2 = dt * fcn(tt(i-1) + dt/2,y2(i-1) + 0.5 * k1);
    k3 = dt * fcn(tt(i-1) + dt/2,y2(i-1) + 0.5 * k2);
    k4 = dt * fcn(tt(i-1) + dt,y2(i-1) + k3);
    y2(i) = y2(i-1) + 1/6 * (k1 + 2 * k2 + 2 * k3 + k4);
end

% adams-bashfort ze startem z rk4
y3 = zeros(1,ttt);
diffs = zeros(1,ttt);
y3(1) = y(1);
for i = 2:ttt
    diffs(i-1) = fcn(tt(i-1),y3(i-1));
    if (i <= 5)        
       % y3(i) = y3(i-1) + dt * diffs(i-1);
        k1 = dt * diffs(i-1);
        k2 = dt * fcn(tt(i-1) + dt/2,y3(i-1) + 0.5 * k1);
        k3 = dt * fcn(tt(i-1) + dt/2,y3(i-1) + 0.5 * k2);
        k4 = dt * fcn(tt(i-1) + dt,y3(i-1) + k3);
        y3(i) = y3(i-1) + 1/6 * (k1 + 2 * k2 + 2 * k3 + k4);
    else        
        y3(i) = y3(i-1) + dt/24 * (55 * diffs(i-1) - 59 * diffs(i-2) + 37 * diffs(i-3) - 9 * diffs(i-4));
    end
end

figure;
plot(t,y,'r');grid on; hold on;
plot(tt,y1,'b');
plot(tt,y2,'g');
plot(tt,y3,'k');
legend('exact','euler','rk4','adams');