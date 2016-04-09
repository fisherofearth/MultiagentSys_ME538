% ========== Question 1 ==========
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
gamma = 0.3; % discount factor
reward = -2; % immediate reward
epsilon = 0.8 % exploitation parameter
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
  	targetLocation = [10 4]; % At the "red square"
    for move = 1 : moveLimit

        % Take action
        currentAgentLocation = agentLocation;
        s = (currentAgentLocation(2) - 1) * worldX  + (currentAgentLocation(1)); 
        [QMax IMax] = max(Q(s, 3:6));

        exp = rand(1);
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

         % Catch target
        if targetLocation == agentLocation
            %reward = reward+100;
            %record( ((trial -1 )*moveLimit + move), :) = [trial move (move*-2)+100   currentAgentLocation(1) currentAgentLocation(2) targetLocation(1) targetLocation(2)];
            record( (trial), :) = [trial move (move*-2)+100   currentAgentLocation(1) currentAgentLocation(2) targetLocation(1) targetLocation(2) sum(record(1:trial, 2)) sum(record(1:trial, 3))];
            s = (currentAgentLocation(2) - 1) * worldX  + (currentAgentLocation(1));
            a = agentActionNum + 2;
            sNew = (agentLocation(2) - 1) * worldX  + (agentLocation(1));
            Q(s, a) = Q(s, a) + alpha * ( 100 + gamma * ( max(Q(sNew, 3:6) )) - Q(s, a));
            break;
        end

       if  move == moveLimit-1
            %record( ((trial -1 )*moveLimit + move), :) = [trial move move*-2    currentAgentLocation(1) currentAgentLocation(2) targetLocation(1) targetLocation(2)];
            record( (trial ), :) = [trial move move*reward    currentAgentLocation(1) currentAgentLocation(2) targetLocation(1) targetLocation(2) sum(record(1:trial, 2)) sum(record(1:trial, 3))];
       end

        s = (currentAgentLocation(2) - 1) * worldX  + (currentAgentLocation(1));
        a = agentActionNum + 2;
        sNew = (agentLocation(2) - 1) * worldX  + (agentLocation(1));
        Q(s, a) = Q(s, a) + alpha * ( reward + gamma * ( max(Q(sNew, 3:6) )) - Q(s, a));

        % Target move
        [targetLocation targetActionNum]= randMove(targetLocation, [worldX worldY]);
    end
    
end

stem(record(1:trialLimit,3));
figure
plot(record(1:trialLimit,8), record(1:trialLimit,9))







