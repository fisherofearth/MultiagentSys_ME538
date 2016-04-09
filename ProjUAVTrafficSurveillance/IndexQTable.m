function [index, a_Q] = IndexQTable(state, stateList )



    SL = stateList';
    s=repmat(state',1,size(stateList)*[1;0]);
    index = find(~any(s-SL,1));
    
end
