% ========== Question 3 ==========
%include function:
%   ifMoveable.m
%   randMove.m


% Define constants
direction = [  
    -1 0;%left
    1 0;%right
    0 -1;%up 
    0 1]; %down

% Define the gridworld
worldX = 10; % width
worldY = 5;  % height

% define parameter
alpha = 0.8; %learning rate
gamma = 0.8; % discount factor
reward = -2; % immediate reward
epsilon = 0.9 % exploitation parameter
T1Reward = 100; %
trialLimit = 300; % no more trial than it
moveLimit = 1000; % no more movement than it within a trial

% Inititl variables
targetLocation = [10 4]; % At the "red square"
% [agentLocation agentActionNum] = randMove(agentLocation, [worldX worldY]);

% Initialize a Q table
% Every initial Q of a action = 100 
Q = zeros(worldX * worldY,6); % Q table = [ x y Q_l Q_r Q_u Q_d]
for y = 1 : worldY
   for x = 1 : worldX
      Q(((y - 1) * worldX  + (x)), :) = [x y 10 10 10 10];
      if x == 1
          Q(((y - 1) * worldX  + (x)), 3) = 0;
      end
      if x == worldX
          Q(((y - 1) * worldX  + (x)), 4) = 0;
      end
   end
end
Q(1:worldX, 5) = zeros(worldX, 1);
Q((worldX*(worldY-1))+1:(worldX*worldY), 6) = zeros(worldX, 1);

record = zeros(trialLimit, 9); 
%record = [trial move reword percent currentAgentLocation[2] targetLocation[2] totalMove toralreward]
  
for trial = 1 : trialLimit
    initialAgentLocation = [random('unid',worldX) random('unid',worldY)]; % A random lovation in the gridworld
    agentLocation = initialAgentLocation;
    agentLocation2 = initialAgentLocation;
  	targetLocation = [10 4]; % At the "red square"
    for move = 1 : moveLimit

        % Take action
        currentAgentLocation = agentLocation;
        currentAgentLocation2 = agentLocation2;
        s = (currentAgentLocation(2) - 1) * worldX  + (currentAgentLocation(1)); 
        s2 = (currentAgentLocation2(2) - 1) * worldX  + (currentAgentLocation2(1)); 
        [QMax IMax] = max(Q(s, 3:6));
        [QMax2 IMax2] = max(Q(s2, 3:6));
        
        exp = rand(1);
        exp2 = rand(1);
        if exp <= epsilon %exploitation
            if IfMoveable(agentLocation, direction(IMax), [worldX worldY]) == 1
                 agentLocation = agentLocation + direction(IMax);
                 agentActionNum = IMax;
            else 
                [agentLocation agentActionNum] = randMove(agentLocation, [worldX worldY]);
            end
        else  %exploration
           agentActionNum = IMax;
            while agentActionNum == IMax
                 [agentLocation agentActionNum] = randMove(agentLocation, [worldX worldY]);
            end
        end
        
        if exp2 <= epsilon %exploitation
            if IfMoveable(agentLocation2, direction(IMax2), [worldX worldY]) == 1
                 agentLocation2 = agentLocation2 + direction(IMax2);
                 agentActionNum2 = IMax2;
            else 
                [agentLocation2 agentActionNum2] = randMove(agentLocation2, [worldX worldY]);
            end
        else  %exploration
           agentActionNum2 = IMax2;
            while agentActionNum2 == IMax2
                 [agentLocation2 agentActionNum2] = randMove(agentLocation2, [worldX worldY]);
            end
        end

         % Catch target
        if targetLocation == agentLocation
            record( (trial), :) = [trial move (move*reward)+100   currentAgentLocation(1) currentAgentLocation(2) targetLocation(1) targetLocation(2) sum(record(1:trial, 2)) sum(record(1:trial, 3))];
            s = (currentAgentLocation(2) - 1) * worldX  + (currentAgentLocation(1));
            a = agentActionNum + 2;
            sNew = (agentLocation(2) - 1) * worldX  + (agentLocation(1));
            Q(s, a) = Q(s, a) + alpha * ( 100 + gamma * ( max(Q(sNew, 3:6) )) - Q(s, a));
            break;
        end
        
         if targetLocation == agentLocation2
            record( (trial), :) = [trial move (move*reward)+100   currentAgentLocation2(1) currentAgentLocation2(2) targetLocation(1) targetLocation(2) sum(record(1:trial, 2)) sum(record(1:trial, 3))];
            s2 = (currentAgentLocation2(2) - 1) * worldX  + (currentAgentLocation2(1));
            a2 = agentActionNum2 + 2;
            sNew2 = (agentLocation2(2) - 1) * worldX  + (agentLocation2(1));
            Q(s2, a2) = Q(s2, a2) + alpha * ( 100 + gamma * ( max(Q(sNew2, 3:6) )) - Q(s2, a2));
            break;
        end

       if  move == moveLimit-1
            record( (trial ), :) = [trial move move*reward    currentAgentLocation(1) currentAgentLocation(2) targetLocation(1) targetLocation(2) sum(record(1:trial, 2)) sum(record(1:trial, 3))];
       end
        s = (currentAgentLocation(2) - 1) * worldX  + (currentAgentLocation(1));
        a = agentActionNum + 2;
        sNew = (agentLocation(2) - 1) * worldX  + (agentLocation(1));
        Q(s, a) = Q(s, a) + alpha * ( reward + gamma * ( max(Q(sNew, 3:6) )) - Q(s, a));
        
        s2 = (currentAgentLocation2(2) - 1) * worldX  + (currentAgentLocation2(1));
        a2 = agentActionNum2 + 2;
        sNew2 = (agentLocation2(2) - 1) * worldX  + (agentLocation2(1));
        Q(s2, a2) = Q(s2, a2) + alpha * ( reward + gamma * ( max(Q(sNew2, 3:6) )) - Q(s2, a2));

        % Target move
        [targetLocation targetActionNum]= randMove(targetLocation, [worldX worldY]);
    end 
end

stem(record(1:trialLimit,3));
figure
plot(record(1:trialLimit,8), record(1:trialLimit,9))







