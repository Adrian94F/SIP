h = 0.001;
dt = 0.2;
t = 0:h:3;
y = exp(sin(t));
tt = 0:dt:3;
ttt = numel(tt);

fcn = @(t,y)(y * cos(t));

y1 = zeros(1,ttt);
y2 = zeros(1,ttt);
[t3,y3] = heun(fcn,0,3,y(1),ttt-1);



y1(1) = y(1);
y2(1) = y(1);
for i = 2:ttt
    % midpoint
    k1 = dt * fcn(tt(i-1), y1(i-1));
    k2 = dt * fcn(tt(i-1) + dt/2, y1(i-1) + 0.5 * k1);
    y1(i) = y1(i-1) + k2;
    
    % heun
    k1 = dt * fcn(tt(i-1), y2(i-1));
    k2 = dt * fcn(tt(i-1) + dt, y2(i-1) + k1);
    y2(i) = y2(i-1) + 0.5 * (k1 + k2);
end

figure;
plot(t,y,'r');grid on; hold on;
plot(tt,y1,'b');
plot(tt,y2,'g');
plot(t3,y3,'k');
legend('exact','midpoint','heun','h');