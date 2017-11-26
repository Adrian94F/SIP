global c; % obiekt wozka
global animIter; % aktualna iteracja animacji

% wyznaczenie kroku animacji na podstawie wynikow symulacji
s = y(:,4); % wektor polozenia wozka
theta = y(:,2) * 180 / pi; % kat nachylenia wahadla
if (h < 0.03)
    skip = 1:(round(0.03/h)):tt;
    s = s(skip);
    theta = theta(skip);
    animStep = 0.03;
else
    animStep = h;
end

% rozpoczecie malowania
f = figure('doublebuffer','on');
figMargin = 0.04;
cartWidth = 0.2;
axes('position', [figMargin figMargin 1-2*figMargin 1-2*figMargin]);axis equal;
standLength = 5;
% dopasowanie osi x do wynikow symulacji i parametrow malowania
minX = -1;
maxX = 1;
if (max(s) > maxX)
    maxX = max(s);
end
if (min(s) < minX)
    minX = min(s);
end
yAxis = [-1.25 1.25]; % dopasowanie osi y do wysokosci wahadla
xAxis = [minX - cartWidth/2 - 0.5,maxX + cartWidth/2 + 0.5];
patch([xAxis(1),xAxis(1),xAxis(2),xAxis(2)],[-1,1,1,-1]*0.01,'k'); % malowanie mocowania

c = cart(cartWidth); % inicjalizacja wozka
set(gca,'XLim',xAxis,'YLim',yAxis);grid on;

% parametry timera odpowiadajacego za uruchomienie animacji
tim = timer('ExecutionMode','fixedRate','Period',animStep,'TasksToExecute',tt);
tim.StartFcn = {@timerStartEnd, 'Rozpoczynam animacje...'};
tim.TimerFcn = {@timerFcn,s,theta};
tim.StopFcn = {@timerStartEnd, 'Koniec animacji'};
% start animacji
tic();
start(tim); % uruchomienie animacji
wait(tim); % zablokowanie wykonania kodu do czasu zakonczenia wykonywania kodu w timerze
toc();
delete(tim);