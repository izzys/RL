classdef (Abstract) Environment < handle


    properties (Abstract)
                
        S; % States 
        R; % Reward R(s,s',a)
        A; % Available actions
        
        Sdim;
        Adim;
    end
    
    methods (Abstract)
        
        [] = Init(Env)

        [ r ] = GetReward(Env,s,a)

        [ s ] = GetNextState(Env,s,a)
        
        [ s ] = DiscretizeState( Env , x  )
        
    end
    

end