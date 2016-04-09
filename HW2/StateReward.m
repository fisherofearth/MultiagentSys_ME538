function [ reward ] = StateReward( attendance, capacity)
%function G( )
    reward = attendance * (exp( -attendance / capacity));
end

