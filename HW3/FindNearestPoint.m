function [ location, locationIndex ] = FindNearestPoint(currentLocation, locationList,stateList, targetStutes)
    amount = size(locationList);
    amount = amount(1,1);

    distanceList = [];
    for i = 1 : amount
        if stateList(i, 1) == targetStutes
            distance = ComputeDistance(currentLocation, locationList(i, :));
            if distance == 0
                distanceList(i) = 1000000;
            else
                distanceList(i) = distance;
            end
        else
            distanceList(i) = 1000000;
        end    
    end

    [nearestDist, Index] = min(distanceList);
    location = locationList(Index, 1:2);
    locationIndex = Index;
end


