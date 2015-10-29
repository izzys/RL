classdef DP < Agent 
 
    properties 
        
         Policy;
         
    end
    
    methods (Access = public)
        
        function [Agt] = DP()
            Agt.Policy  =1;
        end
        
        function [Agt] = Init(Agt)
            
        end
        
        function [Agent,a] = GetAction(Agent,s,r)
            
        end
 
        function [Agent] = SetPolicy(Agent,Pi)
            
        end
     
        function [Agent] = UpdatePolicy(Agent)
            
        end

    end
    
    
    
    methods  (Access = private)
        



     end
end