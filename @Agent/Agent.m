classdef (Abstract) Agent

    
    properties (Abstract)
        
        Policy;

    end
    
    methods (Abstract)
        

         [Agent] = Init(Agent)

         [Agent,a] = GetAction(Agent,s,r)
 
         [Agent] = SetPolicy(Agent,Pi)
     
         [Agent] = UpdatePolicy(Agent)
         
    end
end