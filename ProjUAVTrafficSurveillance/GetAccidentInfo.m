function [ accidentInfo ] = GetAccidentInfo( roadMap, amount)
% accidentInfo - [X Y timeStart timeEnd UAVon]
    sizeY = size(roadMap) * [1; 0] / amount;
    sizeX = size(roadMap) * [0; 1] / amount;
    counter = 1;
    accidentInfo = [];
    for i = 1 : amount
        for j = 1: amount
            r = random('unid', sizeX);
            mat = roadMap((i-1)*sizeY+1:(i)*sizeY, (j-1)*sizeX+r);
            [m, ind] = max(mat);
            if m ~= 0
                accidentInfo(counter, 1:2) = [(j-1)*sizeX+r (i-1)*sizeY + ind];
                
                accidentInfo(counter, 3) = random('unid', 600);
                range = 1000 - accidentInfo(counter, 3);
                accidentInfo(counter, 4) = random('unid', range) + accidentInfo(counter, 3);
                accidentInfo(counter, 5) = 0;

                counter = counter + 1;
            end


        end
    end

end

