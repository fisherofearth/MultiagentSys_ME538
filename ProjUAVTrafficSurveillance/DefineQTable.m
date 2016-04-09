function [ QTable, stateList] = DefineQTable( roadMap,actionNum, initialValue )
% input: 
%   roadMap - 2x2 matrix, 1-> road, 0->other
%   actionNum - amount of possible action

  

sizeX = size(roadMap) * [1; 0];
sizeY = size(roadMap) * [0; 1];
counter = 1;
stateList = [];
for i = 1 : sizeX
    for j = 1 : sizeY 
        if roadMap(j, i) == 1
            stateList(counter,:) = [i j];
            counter  = counter + 1;
        end
    end
end

sizeRoadGrid = sum(roadMap * ones(size(roadMap)*[0;1],1));
QTable = ones(sizeRoadGrid,  actionNum);
QTable = QTable * initialValue;

% if sizeRoadGrid ~= counter - 1
%     error('does not match');
% end

end

