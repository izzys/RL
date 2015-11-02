classdef (Abstract) Agent < handle

    
    properties (Abstract)
        
        Policy;
        Adim;

    end
    
    methods (Abstract)
        

         [] = Init(Agt)

         [a] = GetAction(Agt,s)
 
         [] = SetPolicy(Agt,Pi)
     
         [] = UpdatePolicy(Agt)
         
    end
    
end