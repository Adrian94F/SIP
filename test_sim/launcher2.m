% uzycie ekstrapolatora drugiego rzedu do ustalenia wartosci wejscia ukladu
% co powoduje, ze RK4 mimo obecnosci dodatkowej funkcji u(t) w rownaniu
% rozniczkowym daje dobre wyniki

clear all;

tSim = 10;
global h;
h = 1;
t = (0:h:tSim);
tt = numel(t);

w = [t;sin(t)]';
y1 = zeros(tt,1);
y2 = zeros(tt,1);
y0 = 1;


fcn = @(x,u)(-1/3*x+2/3*u);
for i = 1:tt
    if (i == 1)
        y1(i) = y0;
        y2(i) = y0;
    else
        % RK z FOHem dla sygnalu wejsciowego
        k1 = h * fcn(y1(i-1),w(i-1,2));
        k2 = h * fcn(y1(i-1) + 0.5 * k1,(w(i,2)+w(i-1,2))/2);
        k3 = h * fcn(y1(i-1) + 0.5 * k2,(w(i,2)+w(i-1,2))/2);
        k4 = h * fcn(y1(i-1) + k3,w(i,2));
        y1(i) = y1(i-1) + 1 / 6 * (k1 + 2 * k2 + 2 * k3 + k4);
        %y1(i) = dp(@fcn, y1(i-1),u1(i-1));    
        % euler
        y2(i) = y2(i-1) + h * fcn(y2(i-1),w(i-1,2));
    end
end

% adams-bashfort ze startem z eulera
y3 = zeros(1,tt);
diffs = zeros(1,tt);
y3(1) = y0;
for i = 2:tt
    diffs(i-1) = fcn(y3(i-1),w(i-1,2));
    if (i <= 5)        
        y3(i) = y3(i-1) + h * diffs(i-1);
    else        
        y3(i) = y3(i-1) + h/24 * (55 * diffs(i-1) - 59 * diffs(i-2) + 37 * diffs(i-3) - 9 * diffs(i-4));
    end
end

sim('Untitled2.slx');

figure;
plot(t,y1,'r',t,y2,'g');grid on;hold on;
plot(t,y3,'k');
plot(tSim,ySim,'b');
legend('rk4','euler','adams','simulink');
