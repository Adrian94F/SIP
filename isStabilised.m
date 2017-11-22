function [status] = isStabilised(tSim, h, y)
    if y(tSim / h + 1, 4) <= 0.001
        status = 1;
    else
        status = 0;
    end
end