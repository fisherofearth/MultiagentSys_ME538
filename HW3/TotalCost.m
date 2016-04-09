function [ totalCost ] = TotalCost(locationList, order )


    amount = size(locationList);
    amount = amount(1,1);
    totalCost = 0;
    for i = 1 : amount
        A = order(i,    1);
        B = order(i+1,  1);
        totalCost = totalCost + ComputeDistance(locationList(A,:),locationList(B,:));
    end
    
end

