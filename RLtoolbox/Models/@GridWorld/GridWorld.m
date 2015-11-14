classdef  GridWorld < Environment

    properties 

        S; % States 
        R; % Reward R(s,s',a)
        P; % Probability P(s,s',a)
        A = {'up','down','right','left'}; % Available actions

        Grid;      
        Sdim = 25;
        Adim;
        
        WorldType;
        
    end
    
    methods  (Access = public)
        
        % class cunstructor:
        function [Env] = GridWorld()
            
        end
        
        
        %%%    ~  Abstract fucntions ~  %%%
        
        function [Env] = Init(Env)
                       
            Env.S = 1:Env.Sdim;           
            Env.Grid = reshape(Env.S,sqrt(Env.Sdim),sqrt(Env.Sdim))';
            Env.Adim = length(Env.A);
        end

        function [r] = GetReward(Env,s,a)
            
            s_next = Env.GetNextState(s,a);
       
        switch Env.WorldType
            
            case 'ZeroStart'
            
                if (s_next ==1) || (s_next == Env.Sdim)
                    r = 0;
                else
                    r=-1;  
                end
            
            case 'AB'
                
                r = 0;
                
                if s==s_next
                    r=-1;
                    return;
                end
                
                if (s == 2) && (s_next== 22)
                    r = 10;
                    return;
                end
                
                if (s == 4) && (s_next== 14)
                    r = 5;
                    return;
                end
                
            otherwise
                
                error('Error: World type not defined')
                
                
        end
            
        end

        function [s] = GetNextState(Env,s,a)
            
            [i,j] = find(Env.Grid==s,1,'first');
                 
            switch Env.WorldType
                
                case 'ZeroStart'
                    % do nothing
                
                case 'AB'
                    
                    if s ==2
                        s = 22;
                        return;
                    end
                        
                    if s ==4
                        s = 14;
                        return;
                    end 
                    
                otherwise
                    
                    error('Error: World type not defined')
            end
           
            switch a

                case 'up'
                    try
                    s = Env.Grid(i-1,j);                      
                    end
                case 'down'
                    try
                    s = Env.Grid(i+1,j);
                    end
                case 'right'
                    try
                    s = Env.Grid(i,j+1); 
                    end
                case 'left'
                    try
                    s = Env.Grid(i,j-1);   
                    end
                otherwise
                    error('Error: Action not defined')

            end
            
            
        end
        
        %%%    ~  Added fucntions ~  %%%        
        
        function [ind] = subsindex(Env)
            ind = 0;
        end

    end
    
    
    
     methods  (Access = private)
        



     end
     
     
     methods (Static)
         
           
     end
     

        
end