classdef  Tami < Environment

    properties 

        S = 1:69; % States 
        R; % Reward R(s,s',a)
        P; % Probability P(s,s',a)
        A = {'sex','food','sleep'}% Available actions
      
        Adim;
        Sdim;
        
    end
    
    methods  (Access = public)
        
        % class cunstructor:
        function [Env] = Tami()
            
        end
        
        
        %%%    ~  Abstract fucntions ~  %%%
        
        function [Env] = Init(Env)
                       
            Env.S = Env.BuildStateList();           
            Env.Sdim = length(Env.S);
            Env.Adim = length(Env.A);
        end

        function [r] = GetReward(Env,s,a)
            
            r=1;
     
        end

        function [s] = GetNextState(Env,s,a)
            
            s = s+a;
            
        end
        
        function e = Events(Env,s,a)
            e=0;
        end
            
        
        %%%    ~  Added fucntions ~  %%%
        
        
        function [ s ] = DiscretizeState( Env , x  )
          
            s=x;

        end
        
        function [ d ] = edist( Env, x , y )
            %edist euclidean distance between two vectors
            d = sqrt( sum( (x-y).^2,2 ) );
        end
                
        
        function [ind] = subsindex(Env)
            ind = 0;
        end

     end
    
    
     methods  (Access = private)
        

        function [ states ] = BuildStateList(Env)

               states = Env.S;

        end

     end
     

        
end