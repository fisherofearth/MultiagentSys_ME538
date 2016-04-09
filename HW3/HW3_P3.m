
% input
locationList = cities2;
converged = 50000;

orderOutput = [];
output = [];

amount = size(locationList);
amount = amount(1,1);


%initialize order list
currOrder = [];
for i = 1 : amount
    currOrder(i, 1) = i; 
end
currOrder(amount+1, 1) = 1;


converge = 1;
while converge < converged
    
    % mutate
    %newOrder = Mutate(currOrder,random('unid',2), random('unid',amount - 3));
    newOrder = Mutate(currOrder, 2,random('unid',amount/2));
    
    currTotalCost = TotalCost(locationList, currOrder);
    newTotalCost  = TotalCost(locationList, newOrder)
    if  newTotalCost < currTotalCost
        currOrder = newOrder;
    end
    output(converge,1) = currTotalCost;
    orderOutput(:,1) = currOrder;
    
    
    converge = converge + 1;
end
totalCost = currTotalCost;

hold off;
X = [];
Y = [];
for i = 1: amount
    ordA = orderOutput(i,1);
    ordB = orderOutput(i+1,1);
    X(1, i) = locationList(ordA,1);
    X(2, i) = locationList(ordB,1);
    Y(1, i) = locationList(ordA,2);
    Y(2, i) = locationList(ordB,2);
end
scatter(locationList(:,1),locationList(:,2));
hold on;
plot(X, Y);
figure
plot(output);

