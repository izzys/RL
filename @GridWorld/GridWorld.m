classdef  GridWorld < Environment

    
    properties 

        StDim;
        Grid;

    end
    
    methods  (Access = public)
        
        function [Env] = GridWorld()
            Env.Grid=1;
            Env.StDim =1;
        end
        
        function [Env] = Init(Env)
            
        end

        function [Env,r] = GetReward(Env,a,s)
            
        end

        function [Env,s] = GetNextState(Env,a,s)
            
        end

    end
    
    
    
     methods  (Access = private)
        



     end
end