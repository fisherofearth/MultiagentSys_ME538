function [ ifMoveable ] = IfMoveable(state,direction, boundary)
    newState = state + direction;
    if newState(1,1) <= boundary(1,1) && newState(1,1) > 0 && newState(1,2) <= boundary(1,2) && newState(1,2) > 0
        ifMoveable = 1; %can move
    else 
        ifMoveable = 0; %cannot move
    end

end

