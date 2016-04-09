function [ sysReward, stateRecord] = MainAlgorithm( weekLimit,capacity, agentAmount, nightAvailable, exploration,learningRate, gama, differenceRewawrdType )

% Initial variables
agentExp    = zeros(agentAmount, nightAvailable);
agentAction = zeros(agentAmount, nightAvailable);

state    = zeros(1, nightAvailable);
stateDiff  = zeros(1, nightAvailable); 

% Learning iteration
for week = 1 : weekLimit
    
    % Each agent chooses an action (willing action, not real action)
    for i = 1 : agentAmount
       agentAction(i, :) = ChooseAction(agentExp(i, :), exploration)
    end
    
    % ststem state
    for k = 1 : nightAvailable;
        state(1, k) = sum(agentAction(:,k));
    end
    stateRecord(week,:) = state;
    
    % ststem reward 
    sysReward(week) = SystemReward(state, capacity);
    
    % each agent receives a reward
    for i = 1 : agentAmount 
        
        % know which night agenti attented
        for k = 1: nightAvailable
            if agentAction(i,k) > 0
                break;
            end
        end
        
        
        switch differenceRewawrdType      
            case 'DU0'
                % agent reward = difference DU0               
                stateDiff =  state;
                stateDiff(1, k) = stateDiff(1, k) - 1;  % state without me
                agentReward = SystemReward(state, capacity) - SystemReward(stateDiff, capacity) ;
            case 'DU1'    
                %randomly pick up another action
                r = k;
                while r == k
                    r = random('unid',nightAvailable);
                end
                stateDiff =  state;
                stateDiff(1, k) = stateDiff(1, k) - 1;
                state(1, k) = state(1, k) - 1;
                state(1, r) = state(1, r) + 1;
                agentReward = SystemReward(state, capacity) - SystemReward(stateDiff, capacity);
            case 'G' 
                agentReward = SystemReward(state, capacity);
            case 'local' 
                agentReward = StateReward(state(1, k), capacity) ;
            otherwise
        end
        agentExp(i, k) = agentExp(i, k) + learningRate * ((gama * agentReward) - agentExp(i, k));
    end
    

end

end

