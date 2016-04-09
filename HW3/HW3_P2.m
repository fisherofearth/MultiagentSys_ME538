

%% Main algorithm
% input
locationList = cities2;


%define constants
visited = 0;
unvisited = 1;
 heuristicWeight = 0.2;
% testD = [];
% for  test = 1 : 100
% heuristicWeight = test/100;

orderOutput = 1;
orderOutput(1, 2:3) = locationList(1,:);

amount = size(locationList);
amount = amount(1,1);

% init location status
stateList(1, 1) = visited;
for i = 2 : amount
    stateList(i, 1) = unvisited;
end

currentLocationIndex = 1;

for i = 1 : amount - 1
    output = [];
    
    % Search 
    for j = 1 : amount
        if stateList(j,1) == unvisited
            output(j,1) = Cost( locationList, stateList, currentLocationIndex, j, heuristicWeight); 
        else
            output(j,1) = 100000;
        end
    end
    
    [m mIndex] = min(output(:,1));
    
    currentLocationIndex = mIndex;
    stateList(mIndex, 1) = visited;
    
    orderOutput(i+1, 1) = mIndex;
    orderOutput(i+1, 2:3) = locationList(mIndex,:);
end 

%return to the start point
orderOutput(amount + 1, 1) = 1;
orderOutput(amount + 1, 2:3) = locationList(1,:);



totalCost = 0;
hold off;
X = [];
Y = [];
for i = 1: amount
    X(1, i) = orderOutput(i,2);
    X(2, i) = orderOutput(i+1,2);
    Y(1, i) = orderOutput(i,3);
    Y(2, i) = orderOutput(i+1,3);
    
    totalCost = totalCost + ComputeDistance(orderOutput(i,2:3), orderOutput(i+1,2:3));
end
scatter(locationList(:,1),locationList(:,2));
hold on;
plot(X, Y);


% testD(test)= totalCost;
% end
% 
% 
% plot(0.01:0.01:1,testD)