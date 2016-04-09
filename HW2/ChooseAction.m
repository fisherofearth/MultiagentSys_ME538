function [ action ] = ChooseAction( experience, exploration)
 % output:
 %      action = 1 x K matrix
  
 sizeExp = size(experience);
    K = sizeExp(2);
    action = zeros(1,K);
    
    maxExp = experience(1);
    nightAttend = 1;
    for night = 2 : K
        if experience(night) > maxExp 
            maxExp = experience(night);
            nightAttend = night;
        end
    end
    action(nightAttend) = 1;
    
    
    
    % exploration
    if  rand(1) < exploration
        r = nightAttend;
        while  r == nightAttend
            r = random('unid',K);
        end
        nightAttend = r;
        action(nightAttend) = 1;
       
    end
    
    
end

