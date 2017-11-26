% simulink dla petli zamknietej daje lepsze wyniki z powodu uzycia FOHa

clear all;

tSim = 0.07;
global h;
h = 0.01;
t = 0:h:tSim;
tt = numel(t);

w = 1;
exact = 400/401 - (400*exp(-(401*t)/3))/401;
y1 = zeros(tt,1);
y2 = zeros(tt,1);
y3 = zeros(tt,1);
u1 = zeros(tt,1);
u2 = zeros(tt,1);
u3 = zeros(tt,1);
y0 = 0;
k = 200;



for i = 1:tt
    if (i == 1)
        y1(i) = y0;
        y2(i) = y0;
    else
        % rk4
        k1 = h * fcn(y1(i-1), u1(i-1));
        k2 = h * fcn(y1(i-1) + 0.5 * k1, u1(i-1));
        k3 = h * fcn(y1(i-1) + 0.5 * k2, u1(i-1));
        k4 = h * fcn(y1(i-1) + k3, u1(i-1));
        y1(i) = y1(i-1) + 1 / 6 * (k1 + 2 * k2 + 2 * k3 + k4);
        
        % heun
        fi = fcn(y1(i-1), u1(i-1));
        y3(i) = y3(i-1) + h/2 * (fi + fcn(y1(i-1) + h * fi, u1(i-1)));
        
        % euler
        y2(i) = y2(i-1) + h * fcn(y2(i-1),u2(i-1));
    end
    u1(i) = k*(w - y1(i));
    u2(i) = k*(w - y2(i));
    u3(i) = k*(w - y3(i));
end

sim('Untitled1.slx');

figure;
plot(t,exact,'k'); grid on;hold on;
plot(t,y1,'r',t,y2,'g');grid on;hold on;
plot(t,y3,'y');grid on;hold on;
plot(tSim,ySim,'b');
legend('exact','rk4','euler','heun','simulink');
