function [ newOrder ] = Mutate( currOrder, mode, p)

    amount = size(currOrder);
    amount = amount(1,1);
    newOrder = currOrder;

    switch mode 
        case 1 %exchange
            sw = random('unid', (amount - 3 - p)) + 1 ;
            newOrder(sw + p + 1) = currOrder(sw);
            newOrder(sw) = currOrder(sw + p + 1);   
        case 2 %pick and inset
            for i = 1 : p
                pick = random('unid', (amount - 2)) + 1 ;
                newOrder(pick:amount-1,1) = newOrder(pick+1:amount,1);

                inset = random('unid', (amount - 3)) + 1 ;
                newOrder(inset+1:amount-1,1) = newOrder(inset:amount-2,1);
                newOrder(inset, 1) = currOrder(pick);
                currOrder = newOrder;
            end
        otherwise
    end
            
    
end

