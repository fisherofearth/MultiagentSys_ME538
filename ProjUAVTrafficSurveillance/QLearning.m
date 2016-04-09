function [ QTable, GReward ] = QLearning( QTable, stateList, learningRate,discountFactor, roadMap, trafficMap,frequenceMap, accidentInfo, stateUAVs, predictTime, densitySuv, rewardSelect)

    %define direction
    GoRight = [1 0];
    GoLeft = [-1 0];
    GoUp = [0 1];
    GoDown = [0 -1];

    GoUpRight = [1 1];
    GoUpLeft = [-1 1];
    GoDownRight = [1 -1];
    GoDownLeft = [-1 -1];

    possibleAction = [GoRight; GoLeft; GoUp; GoDown; GoUpRight; GoUpLeft; GoDownRight; GoDownLeft];
    
%     s = state;
%     a = action;
    sList = stateList;
    timePointLast = zeros(500, 500);
    UAVStayOn = zeros(size(stateUAVs) * [1;0], 1);%enable all UAV, if not 0 -> UAV is staying on the location of this index pointing in [accidentInfo]
    
    for time = 1 : predictTime 
        process = time / predictTime;
        if rem(process,10)== 0
            aaaa = process
        end
        for agent = 1 : size(stateUAVs) 
            if UAVStayOn(agent,1) > 0
                index = UAVStayOn(agent,1);
                if time >  accidentInfo(index, 4)
                    accidentInfo(index, 5) = 0;
                    UAVStayOn(agent) = 0;
                end
            else
                % find the curernt state reflecting in QTable
                zCurr= IndexQTable(stateUAVs(agent,:), sList );  
%                 aCurr = a;
                % find the Q value of the best action (max)
                state = stateUAVs(agent, :);
                possibleState = possibleAction + ones(8,1) * state;
               counter = 1;
%                 possibleQvalue = [];
                Q_bestAction= 0;
                ra = rand(1);
                if ra < 0.25
                    ranAction = random('unid', 8);
                    
                    while roadMap(possibleState(ranAction, 2), possibleState(ranAction, 1)) == 0 % if not on the road
                        ranAction = random('unid', 8);
                    end
                    zPoss = IndexQTable(possibleState(ranAction, 1:2), stateList );    
                    Q_bestAction = QTable(zPoss,ranAction);
                    bestAction = ranAction;
                else
                    for j = 1 : 8
                        if roadMap(possibleState(j, 2), possibleState(j, 1)) == 1 % if on the road
                            zPoss = IndexQTable(possibleState(j, 1:2), stateList );
                            if  QTable(zPoss,j) > Q_bestAction
                                Q_bestAction = QTable(zPoss,j);
                                bestAction = j;
                            end
                        end
                    end
                end
                 % agent move
                stateUAVs(agent, :) = stateUAVs(agent, :) + possibleAction(bestAction, :);
                

                for ii = 1 : 500
                    for jj = 1 : 500
                        frequenceMap(jj, ii) = 1 / (time + (1/agent)- timePointLast(jj, ii));
                    end
                end
                
                xUAV = stateUAVs(agent, 1);
                yUAV = stateUAVs(agent, 2);               
                 feqWithoutAction = frequenceMap(yUAV, xUAV);
                frequenceMap(yUAV, xUAV) = 1 / (time + (1/agent) - timePointLast(yUAV, xUAV));
                timePointLast(yUAV, xUAV) = frequenceMap(yUAV, xUAV);

                QTable(zCurr, bestAction) = QTable(zCurr, bestAction) + learningRate * (Reward(stateList(zCurr,1:2), frequenceMap,trafficMap, densitySuv, feqWithoutAction,rewardSelect) + discountFactor * Q_bestAction - QTable(zCurr, bestAction));
                
                    
                % if on POI
                index = matchPOI(accidentInfo, stateUAVs(agent, :));
                if index > 0
                    if time >= accidentInfo(index, 3) && time <= accidentInfo(index, 4)
                        accidentInfo(index, 5) = 1;
                        UAVStayOn(agent) = index;
                    end
                end
            end
        end
        
        Gz = 0;
        for x = 1 : 500
            for y = 1 : 500
                if trafficMap(y, x) > 0
                    f = frequenceMap(y, x);
                    T = trafficMap(y, x);
                    Gz = Gz + ( f/ T - densitySuv)^2;
                end
            end
        end
        GReward(1,time) = exp(Gz);
        
    end
end


function [reward] = Reward(state, frequenceMap,trafficMap, densitySuv, feqWithoutAction,rewardSelect)
    Gz = 0;
    for x = 1 : 500
        for y = 1 : 500
            if trafficMap(y, x) > 0
                f = frequenceMap(y, x);
                T = trafficMap(y, x);
                Gz = Gz + ( f/ T - densitySuv)^2;
            end
        end
    end
    if Gz > 1e+1 
        Gz = 1e+1;
    end
    
   
    
    switch rewardSelect
        case 'local'
            f = frequenceMap(state(2), state(1));
            T = trafficMap(state(2), state(1));
            reward =  - exp(((f/T) - densitySuv)^2) ;
        case 'system'
            reward =  exp(Gz);
        case 'diff'       
            f = frequenceMap(state(2), state(1));
            T = trafficMap(state(2), state(1));
            Gzi =  Gz - (((f/T) - densitySuv)^2) + (((feqWithoutAction/T) - densitySuv)^2);
            reward =exp(Gzi) - exp(Gz) ; 
        otherwise
    end
    
end

function [index] = matchPOI(accidentInfo, state)
    list = accidentInfo(:,1:2);
    SL = list';
    s=repmat(state',1,size(list)*[1;0]);
    index = find(~any(s-SL,1));
    
end