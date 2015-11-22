classdef  GridWorld < Environment

    properties 

        S; % States 
        R; % Reward R(s,s',a)
        A = {'up','down','right','left'}; % Available actions

        P; % Probability P(s,s',a)
                
        Grid;      
        Sdim = 64;;
        Adim;
        
        WorldType = 'AB';
        
        row_dim;
        column_dim;
        
        const_IC = 1;
        random_IC = 'randi(64)';
        
        RenderObj;
        
        %parameters for AB world type:
        A_state = 2;
        Ap_state = 22;
        B_state = 4;
        Bp_state = 55;
    end
    
    methods  (Access = public)
        
        % class cunstructor:
        function [Env] = GridWorld()
            
        end
        
        
        %%%    ~  Abstract fucntions ~  %%%
        
        function [] = Init(Env)
                       
            Env.S = (1:Env.Sdim)';           
            Env.Grid = reshape(Env.S,sqrt(Env.Sdim),sqrt(Env.Sdim))';
            Env.Adim = length(Env.A);
            
            Env.row_dim = size(Env.Grid,1);
            Env.column_dim = size(Env.Grid,2);
            
            if ~isempty(Env.RenderObj)
                
                names = fieldnames(Env.RenderObj);
                for i=1:length(names)
                 delete(eval(['Env.RenderObj.' names{i}]));
                end
                Env.RenderObj = [];
            else
                Env.RenderObj = [];
            end
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
                
                r = -1;
                
                if s==s_next
                    r=-5;
                    return;
                end
                
                if (s == Env.A_state) && (s_next== Env.Ap_state)
                    r = 100;
                    return;
                end
                
                if (s == Env.B_state) && (s_next== Env.Bp_state)
                    r = 50;
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
                    
                    if s == Env.A_state
                        s = Env.Ap_state;
                        return;
                    end
                        
                    if s == Env.B_state
                        s = Env.Bp_state;
                        return;
                    end 
                    
                otherwise
                    
                    error('Error: World type not defined')
            end
           
            
            action = Env.A{a};
            
            switch action

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
        
        function [ s ] = DiscretizeState( Env , x  )
          
                s=x;

        end
        
        function [e] = Events(Env,s,a)            
            e = 0;
        end
                
        %%%    ~  Added fucntions ~  %%%        
        
        function [ind] = subsindex(Env)
            ind = 0;
        end

    end
     

        
end