% porownanie czasu wykonywania symulacji w Simulinku i ze skryptu

clearvars;

tSim = 10;
h = 0.0001;
t = 0:h:tSim;
tt = numel(t);
y0 = 3;
u = 1;

% skrypt
tic();
y(1) = y0;
for i = 2:tt
   y(i) = y(i-1) + h * (-1/2 * y(i-1) + 2/2 * u); 
end
toc();

% zwykly model
tic();
sim('mdl1.slx');
toc();

% sfunkcja
tic();
sim('mdl2.slx');
toc();

% dyskretny + matlab function
tic();
sim('mdl3.slx');
toc();

plot(t,y,t1,y1,t2,y2);
