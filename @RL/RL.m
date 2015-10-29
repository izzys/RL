classdef RL 
 
    properties 
        
        Agt; 
        Env;

    end
    
    methods
        
        function [RL] = RL(agent,environment)
            RL.Agt = agent;
            RL.Env = environment;
        end
        
        function [RL] = Init(RL)
        end
        
        function [RL] = Run(RL)   
        end

    end
end