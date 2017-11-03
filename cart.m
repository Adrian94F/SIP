classdef cart
    properties(Access = public)
        cartWidth;
        cartHeight;
        pendulumLength;
        pendulumThickness;
        bigRadius = 0.05;
        smallRadius = 0.025;
        
        patches = [];
        cartAxis;
        
        lastX = 0;
        lastTheta = 0;
    end
    methods(Access = public)
        function obj = cart(width)
            obj.cartWidth = width;
            obj.cartHeight = width / 2;
            obj.pendulumLength = 5 * width;
            obj.pendulumThickness = width / 10;
            obj.bigRadius = width / 4;
            obj.smallRadius = width / 8;
            
            x = [-obj.cartWidth/2,-obj.cartWidth/2,obj.cartWidth/2,obj.cartWidth/2];
            y = [-obj.cartHeight/2,obj.cartHeight/2,obj.cartHeight/2,-obj.cartHeight/2];
            obj.patches = [obj.patches,patch(x,y,'r')];
            t = 0:pi/10:2*pi;
            st = sin(t);
            ct = cos(t);
            x = obj.bigRadius * st;
            y = obj.bigRadius * ct + obj.cartHeight/2;
            obj.patches = [obj.patches,patch(x,y,'y')];
            x = [-obj.pendulumThickness/2,obj.pendulumThickness/2,obj.pendulumThickness/2,-obj.pendulumThickness/2];
            y = [obj.cartHeight/2,obj.cartHeight/2,obj.cartHeight/2+obj.pendulumLength,obj.cartHeight/2+obj.pendulumLength];
            obj.patches = [obj.patches,patch(x,y,'b')];
            x = obj.smallRadius * st;
            y = obj.smallRadius * ct + obj.cartHeight/2;
            obj.patches = [obj.patches,patch(x,y,'y')];
            obj.cartAxis = [0,obj.cartHeight/2,0];
        end
        function obj = move(obj,x)
            delta = x - obj.lastX;
            for i = 1:numel(obj.patches)
                newPos = get(obj.patches(i),'XData') + delta;
                set(obj.patches(i),'XData',newPos);
            end
            obj.cartAxis(1) = obj.cartAxis(1) + delta;
            obj.lastX = x;
        end
        function obj = rotate(obj,theta)
            delta = theta - obj.lastTheta;
            rotate(obj.patches(3),[0 0 -1],delta,obj.cartAxis);
            obj.lastTheta = theta;
        end
    end
end