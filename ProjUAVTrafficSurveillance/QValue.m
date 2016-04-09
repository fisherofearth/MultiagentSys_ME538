function [ q, z, a ] = QValue(state, action, QTable, stateList )
% state - [x y]
% action - integer
% stateList - [x1 y1; x2 y2; ...]

    z_Q = IndexQTable(state, stateList );
    q = QTable(z_Q, action);
    
end
