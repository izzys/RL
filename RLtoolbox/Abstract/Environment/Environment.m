classdef (Abstract) Environment < handle


    properties (Abstract)
                
        S; % States 
        R; % Reward R(s,s',a)
        P; % Probability P(s,s',a)
        A; % Available actions
        
        Sdim;
        Adim;
    end
    
    methods (Abstract)
        
        [Env] = Init(Env)

        [Env,r] = GetReward(Env,s,a)

        [Env,s] = GetNextState(Env,s,a)
        
    end
    

end