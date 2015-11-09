classdef StochasticDP < Agent
 
    properties 
        
         Policy;

    end
    
    methods (Access = public)
        
        % class cunstructor:
        function [Agt] = StochasticDP()
        end
        
        %%%    ~  Abstract fucntions ~  %%%
        
        function [] = Init(Agt)
            Agt.Policy = [];
        end
        
        function [a] = GetBestAction(Agt,s)        
                        
            % labels and probabilities:
            labels = Agt.Policy(s).A_id;
            probabilities = Agt.Policy(s).P;

            % cumulative distribution
            cp = [0 cumsum(probabilities)];

            %Draw point at random according to probability density
            draw = rand();
            higher = find(cp >= draw==1,1);
            drawn_a_id = labels(higher-1); 
            
            a = Agt.Policy(s).A_id(drawn_a_id);
            
        end
 
        function [] = SetPolicy(Agt,Pi)
            
            Agt.Policy = Pi;
            
        end
     
        function [] = UpdatePolicy(Agt)
            
        end
       
        %%%    ~  Added fucntions ~  %%% 

               
        function [ind] = subsindex(Agt)
            ind = 0;
        end
           
        

    end
    
    
    
    methods  (Access = private)
        



    end
     
    methods (Static)
         

     end
end