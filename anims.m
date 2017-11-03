global c;
global animIter;
% ograniczenie klatek
s = y(:,4);
theta = y(:,2) * 180 / pi;
if (h < 0.03)
    skip = 1:(round(0.03/h)):tt;
    s = s(skip);
    theta = theta(skip);
    animStep = 0.03;
else
    animStep = h;
end

f = figure('doublebuffer','on');
figMargin = 0.04;
cartWidth = 0.2;
axes('position', [figMargin figMargin 1-2*figMargin 1-2*figMargin]);axis equal;
standLength = 5;
%limiterSize = standLength/10;
%temp = standLength/2 + limiterSize/2;
%xAxis = [-(temp + limiterSize) (temp + limiterSize)];
minX = -1;
maxX = 1;
if (max(s) > maxX)
    maxX = max(s);
end
if (min(s) < minX)
    minX = min(s);
end
yAxis = [-1.25 1.25];
xAxis = [minX - cartWidth/2 - 0.5,maxX + cartWidth/2 + 0.5];
patch([xAxis(1),xAxis(1),xAxis(2),xAxis(2)],[-1,1,1,-1]*0.01,'k');
%patch([-temp - limiterSize,-temp,-temp,-temp - limiterSize],[1,1,-1,-1]*(limiterSize/2),'k');
%patch([temp,temp + limiterSize,temp + limiterSize,temp],[1,1,-1,-1]*(limiterSize/2),'k');
c = cart(cartWidth);
set(gca,'XLim',xAxis,'YLim',yAxis);grid on;

% parametry timera
tim = timer('ExecutionMode','fixedRate','Period',animStep,'TasksToExecute',tt);
tim.StartFcn = {@timerStartEnd, 'Rozpoczynam animacje...'};
tim.TimerFcn = {@timerFcn,s,theta};
tim.StopFcn = {@timerStartEnd, 'Koniec animacji'};
% start animacji
tic();
start(tim);
wait(tim);
toc();
delete(tim);