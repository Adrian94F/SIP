clearvars;

h = 0.001;
dt = 0.2;
t = 0:h:3;
y = exp(sin(t));
tt = 0:dt:3;
ttt = numel(tt);

fcn = @(t,y)(y * cos(t));

y1 = zeros(1,ttt);
diffs = zeros(1,ttt);

y1(1) = y(1);
for i = 2:ttt
    diffs(i-1) = fcn(tt(i-1),y1(i-1));
    if (i < 5)        
        k1 = dt * diffs(i-1);
        k2 = dt * fcn(tt(i-1) + dt/2,y1(i-1) + 0.5 * k1);
        k3 = dt * fcn(tt(i-1) + dt/2,y1(i-1) + 0.5 * k2);
        k4 = dt * fcn(tt(i-1) + dt,y1(i-1) + k3);
        y1(i) = y1(i-1) + 1/6 * (k1 + 2 * k2 + 2 * k3 + k4);
    else    
        y1(i) = y1(i-1) + dt/24 * (55 * diffs(i-1) - 59 * diffs(i-2) + 37 * diffs(i-3) - 9 * diffs(i-4));
        %y1(i) = y1(i-1) + dt/24 * (9 * fcn(tt(i),yp) + 19 * diffs(i-1) - 5 * diffs(i-2) + diffs(i-3));
    end
end
[t2, y2]=maadams4(fcn,[0 3],y(1),dt);
y2 = y2';

figure;
plot(t,y,'r');grid on; hold on;
plot(tt,y1,'b');
plot(t2,y2,'k');
legend('exact','adams','a');