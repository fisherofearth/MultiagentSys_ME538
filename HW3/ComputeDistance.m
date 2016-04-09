function [distance] = ComputeDistance (locationA, locationB)
    M = locationA(1, 1) - locationB(1, 1);
    N = locationA(1, 2) - locationB(1, 2);
    distance = ((M^2) + (N^2))^(1/2);
end