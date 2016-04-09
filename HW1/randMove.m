
function [ newState, actionNum ] = randMove(state, boundary)
% Parameter : 
%    state = [locationX, locationY]
%    boundary = [worldLimitX, worldLimitY]
% state = [10 5];
% boundary=[10 5];

d = [  
    -1 0;%left
    1 0;%right
    0 -1;%up 
    0 1]; %down

for i = 1 : 4 
    
        randomN = random('unid',4-i+1);
        dir = d(randomN, :);
        newState = state + dir;
        actionNum = randomN;
        
       if  IfMoveable(state, dir, boundary) == 1
           break;
       end
%         if newState(1,1) <= boundary(1,1) && newState(1,1) > 0 && newState(1,2) <= boundary(1,2) && newState(1,2) > 0
%             break;  
%         end
        d(randomN,:) =[];
end  

end

