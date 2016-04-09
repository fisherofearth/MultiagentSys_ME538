function [ cost ] = Cost( locationList, stateList, currentLocationIndex, targetLocationIndex, hWeight)

    gCost = ComputeDistance(locationList(currentLocationIndex,:), locationList(targetLocationIndex,:));
    cost = gCost + (Heuristic( locationList, stateList, targetLocationIndex) * hWeight);
    
end

function [ heuristic ] = Heuristic( locationList, stateList, targetLocationIndex )
    visited = 0;
    unvisited = 1;
    current = 2;

    myLocationList = locationList;
    myStateList = stateList;
    heuristic = 0;
    k = 0;
    for i = 1 : size(myStateList)
        if myStateList(i,1) == unvisited;
            k = k + 1;  
        end
    end
    
    myStateList(targetLocationIndex) = visited;
    locationIndex = targetLocationIndex;
    for i = 1 : k
        
        [nearestLocation  nearestLocationIndex] = FindNearestPoint(myLocationList(locationIndex, :), myLocationList, myStateList, unvisited);
        heuristic = heuristic + ComputeDistance(nearestLocation, locationList(locationIndex, :));
        locationIndex = nearestLocationIndex;
        myStateList(nearestLocationIndex) = visited;  
    end
end

