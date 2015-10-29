classdef (Abstract) Environment


    properties (Abstract)
        
        StDim;
        
    end
    
    methods (Abstract)
        
        [Env] = Init(Env)

        [Env,r] = GetReward(Env,a,s)

        [Env,s] = GetNextState(Env,a,s)
        
        

    end
end