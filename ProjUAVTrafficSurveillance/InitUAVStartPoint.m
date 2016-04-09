function [ stateUAVs ] = InitUAVStartPoint(roadMap, numUAV )

sizeX = size(roadMap) * [0; 1] / numUAV;
sizeY = size(roadMap) * [1; 0];

for i = 1 : numUAV
    
    x = round((i-1)*sizeX + (sizeX / 2));
    
    y = random('unid', sizeY);
    while roadMap(y, x) == 0 
        y = random('unid', sizeY);
    end
    stateUAVs(i, :) = [x y];
end



end

