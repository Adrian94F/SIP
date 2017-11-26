% malowanie wykresow na podstawie wynikow symulacji

figure;
subplot(3,1,1);
% polozenie i predkosc katowa wahadla
plot(t, y(:,1:2));grid on;
l = legend('$\dot{\theta}$','$\theta$');
set(l,'Interpreter','Latex');
subplot(3,1,2);
% polozenie i predkoscl liniowa wozka
plot(t, y(:,3:4));grid on;
legend('v','s');
subplot(3,1,3);
% wartosc zadana wychylenia wahadla i sterowanie z regulatora
plot(t, u,'b');hold on; grid on;
plot(t, setTheta(:,2),'r');
legend('sterowanie','wartosc zad.');