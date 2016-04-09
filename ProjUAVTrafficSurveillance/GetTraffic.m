function [ trafficMap, amount] = GetTraffic( roadMap, rawTrafficMap )

for i = 1 : size(roadMap) * [0; 1]
    for j = 1: size(roadMap) * [1; 0]
        trafficMap(j,i) = roadMap(j,i) * rawTrafficMap(j,i);
    end
end



end

