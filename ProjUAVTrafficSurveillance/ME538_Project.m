%define input paramters
numUAV = 20;% max 250
numAction = 8;
initQValue = 0;
numAccident = 4;%option = { 1 2 4 5}, actual number is (numAccident^2)
predictTime = 600;% in 1/10 minute = 6 sec
densitySuv = 0.002; % (frequence of survallance / traffic flow)
learningRate = 0.5;
discountFactor = 0.5;

% get road map
roadMap = ((double(imread('roadmap.bmp'))/15) * (-1) +1);
roadMap(1, :) = zeros(1,500);
roadMap(500, :) = zeros(1,500);
roadMap(:,1) = zeros(500,1);
roadMap(:,500) = zeros(500,1);

% get traffic map
rawTrafficMap =double(imread('T.png'));
trafficMap = GetTraffic( roadMap, rawTrafficMap(:,:,2) ); %traffic flow map
trafficMap =trafficMap * 100;

% get accident info
accidentInfo = GetAccidentInfo(roadMap, numAccident);

% define Q table and state list
[QTable, stateList] = DefineQTable(roadMap, numAction,1);

% Initialize start point for  
stateUAVs = InitUAVStartPoint(roadMap, numUAV);

% initialize frequence of survallance
frequenceMap = roadMap * 0.001;

% Learning

GReward = [];
for i = 1 :500;
    [QTable, GReward(i,:) ] = QLearning( QTable, stateList,...
        learningRate,discountFactor, roadMap, trafficMap,frequenceMap, ...
        accidentInfo, stateUAVs, predictTime, densitySuv,'diff');
end
  
GReward = [];
for i = 1 :500;
    [QTable, GReward(i,:) ] = QLearning( QTable, stateList,...
        learningRate,discountFactor, roadMap, trafficMap,frequenceMap, ...
        accidentInfo, stateUAVs, predictTime, densitySuv,'system');
end


% 
% %%
% % graphic test
% 
% contour(rot90(trafficMap'));
% image(roadMap*255);
% hold on
% scatter(stateUAVs(:,1), stateUAVs(:,2));
% hold off
% 
% 
% Q = QValue(state, action, QTable, stateList ); % pick a Q value