%% Main algorithm
% Input parameter
weekLimit   = 1000; 
capacity    = 4; %b
agentAmount = 30; % must be bigger than capacity
nightAvailable = 6; % How many nights are available every week
learningRate = 0.2;
gama = 0.5;
smoothP = 20;
exploration = 0.03;
R = [];
stateRecord=[];
SR= [];

agentRewawrdType = 'G';% blue
[sysReward, stateRecord] = MainAlgorithm( weekLimit,capacity, agentAmount, nightAvailable, exploration, learningRate,gama, agentRewawrdType);
R(:,1) = sysReward';

agentRewawrdType = 'local';% green
[sysReward, stateRecord] = MainAlgorithm( weekLimit,capacity, agentAmount, nightAvailable, exploration, learningRate,gama, agentRewawrdType);
R(:,2) = sysReward';

agentRewawrdType = 'DU0';% red
[sysReward, stateRecord] = MainAlgorithm( weekLimit,capacity, agentAmount, nightAvailable, exploration, learningRate, gama, agentRewawrdType);
R(:,3) = sysReward';

SR(:, 1) = smooth(R(:,1),smoothP , 'moving');
SR(:, 2) = smooth(R(:,2),smoothP , 'moving');
SR(:, 3) = smooth(R(:,3),smoothP , 'moving');
figure
plot(SR);

stateHist = [];
for k = 1 : nightAvailable;
    stateHist((k-1)*weekLimit+1:k*weekLimit , 1) = stateRecord(:,k);
end
figure    
hist(stateHist,50);
