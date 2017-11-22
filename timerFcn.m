function timerFcn( obj,event,s,theta)
    i = get(obj,'TasksExecuted');
    deltaT = get(obj,'Period');
    global c;
    c = c.move(s(i));
    c = c.rotate(theta(i));
    
    drawnow;
    
    %gifGen(i, deltaT);
end
