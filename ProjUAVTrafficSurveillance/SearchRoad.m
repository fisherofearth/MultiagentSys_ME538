function [ roadMap ] = SearchRoad( map )
%input a 0/1 map
% 0 - road area
% 1 - non-road area


%for test
% map = (data);



mapSize = size(map);
roadMap = ones(mapSize);


%define constant
X = 2;
Y = 1;
RoadArea = 0;
GoLeft = [-1; 0];
GoRight = [1; 0];
GoUp= [0; -1];
GoDown = [0; 1];
turnLeft = [0 1; -1 0];
turnRight = [0 -1; 1 0];
% turnLeft * GoRight
% turnRight * GoRight


%inititalize variables
LoRS= []; % location of road Searcher's 
intersection= [];
LastAction = GoDown;
NextAction = [];

%find a start location for roadSearcher
[m, x] = min(map(2,:));
LoRS = [x; 2];
map(LoRS(X), LoRS(Y)) = RoadArea;


    for i = 1 : (mapSize(1)-2)*(mapSize(2)-2) -1

        
       straLoRS = LoRS + LastAction;
       leftLoRS = LoRS + (turnLeft * LastAction);
       righLoRS = LoRS + (turnRight * LastAction);
       
       strLeftLoRS = LoRS + LastAction + (turnLeft * LastAction);
       strRighLoRS = LoRS + LastAction + (turnRight * LastAction);
       
       if map(straLoRS(X), straLoRS(Y)) == RoadArea
           LoRS = straLoRS;
           roadMap(LoRS(X), LoRS(Y)) = RoadArea;
       elseif map(leftLoRS(X), leftLoRS(Y)) == RoadArea
           LoRS = leftLoRS;
           roadMap(LoRS(X), LoRS(Y)) = RoadArea; 
           LastAction = (turnLeft * LastAction);
       elseif map(righLoRS(X), righLoRS(Y)) == RoadArea
           LoRS = righLoRS;
           roadMap(LoRS(X), LoRS(Y)) = RoadArea; 
           LastAction = (turnRight * LastAction);
       elseif map(strLeftLoRS(X), strLeftLoRS(Y)) == RoadArea
           LoRS = strLeftLoRS;
           roadMap(straLoRS(X), straLoRS(Y)) = RoadArea;
           roadMap(LoRS(X), LoRS(Y)) = RoadArea;
           LastAction = (turnLeft * LastAction); 
       elseif map(strRighLoRS(X), strRighLoRS(Y)) == RoadArea
           LoRS = strRighLoRS;
           roadMap(straLoRS(X), straLoRS(Y)) = RoadArea;
           roadMap(LoRS(X), LoRS(Y)) = RoadArea;
           LastAction = (turnRight * LastAction);     
       else
           break;
       end


    end


    
end



