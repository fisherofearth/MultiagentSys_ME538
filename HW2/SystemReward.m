function [ systemReward ] = SystemReward(state, capacity)
% The function of calculating the sum of system reward.
% acction = N x K
    systemReward = 0;
    s = size(state);
    for night = 1 : s(2)
        systemReward = systemReward + StateReward(state(1, night), capacity); 
    end
    
end

