classdef ReinforcementLearning < handle
 
    properties 
        
        % handle to method function:
        MethodFcn;
        
        % contains model object:
        Env;
        
        % list of avaiable models. make sure to match list on RLgui:
        MethodList = {'DP',...
                      'MonteCarlo',...
                      'SARSA',...
                      'Qlearning',...
                      'TDlambda',...
                      []};
            
        % list of avaiable methods. make sure to match list on RLgui:
        ModelList = {'GridWorld()',...
                     'CartPole()',... 
                     'AcroBot()',...
                     'Tami()',...
                         []};
        
        % learning parameters:       
        gamma;
        alpha;
        alpha_decrease;
        alpha_decrease_val
        eps;
        eps_decrease;
        eps_decrease_val;
        lambda;
        max_steps ;
        
        
        % Running params:
        MaxEpisodes = 1e6;
        StopLearning;
        
        % value or state-value matrixes:
        V;
        Q;
        
        % model dimensions:
        Adim;
        Sdim;
        
        % inital conditions for each episode:
        IC;
        random_IC;
        enable_random_IC;
        
        % enable model graphics:
        grafics;
        plot_learning_handle;
        plot_Q_handle;
        plot_model_handle;
    end
    
    methods
        
        % class constructor:
        function [RL] = ReinforcementLearning(varargin)
            
             switch nargin
            
                 case 0
                     %do nothing
                     
                 case 2
                     RL.MethodFcn = str2func( varargin{1} );
                     RL.Env = varargin{2};
             end
        end
        
        % Initialize agent befor new learning session:
        function [] = Init(RL,varargin)
                    
            RL.Sdim = RL.Env.Sdim;
            RL.Adim = RL.Env.Adim;
            
            RL.V = zeros(1,RL.Sdim);
            RL.Q = zeros(RL.Adim,RL.Sdim);
            
            RL.StopLearning = 0;
              
        end
          
        % Start and run the learning process:
        function [] = StartLearning(RL,varargin)
           
            
            switch nargin
                case 1
                  RL.plot_learning_handle = figure;  
                case 2
                  RL.plot_learning_handle = varargin{1};
                  RL.plot_Q_handle = figure;
                case 3
                  RL.plot_learning_handle = varargin{1}; 
                  RL.plot_Q_handle = varargin{2};
                case 4
                  RL.plot_learning_handle = varargin{1}; 
                  RL.plot_Q_handle = varargin{2}; 
                  RL.plot_model_handle = varargin{3}; 
            end

            if isvalid(RL.Env)
                  RL.Init();
            else
                  error('Environment is not loaded')
            end

            xpoints     = [];
            ypoints     = [];
            
            episode=1;
            
            while episode<RL.MaxEpisodes && ~RL.StopLearning   

                [total_reward,steps] = RL.Episode(); 

                disp(['Espisode: ',int2str(episode),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])

                RL.eps = RL.eps_decrease_val*RL.eps;

                xpoints(i)=i-1;
                ypoints(i)=steps;    

                plot(RL.plot_learning_handle,xpoints,ypoints,'.','Color',[rand(1) rand(1) rand(1)])      
                title(['Episode: ',int2str(episode),' epsilon: ',num2str(RL.eps)])  
                xlabel('Episodes')
                ylabel('Steps')    
                drawnow
                
                episode = episode+1;

            end
        end
        
        % Get action for next step - based on current policy:
        function [a] = GetAction(RL,s)
          
            a = feval(RL.MethodFcn,RL,'GetBestAction',s) ;  
            
        end
        
        % An episode runs for #steps or until the goal is reached:
        function [total_reward,steps] = Episode(RL)

            RL.Env.Init();
            
            if RL.enable_random_IC
                x  = str2num( RL.random_IC );
            else
                x = RL.IC;
            end
            steps        = 0;
            total_reward = 0;

            % convert the continous state variables to an index of the statelist:
            s   = RL.Env.DiscretizeState(x);
            % selects an action using the current strategy:
            a   = RL.GetAction(s);
      
            for k=1:RL.max_steps     

                % do the selected action and get the next state:   
                xp  = RL.Env.GetNextState( x , a  );    

                % observe the reward at state xp
                [r]   = RL.Env.GetReward(x,a);
                stop_episode = RL.Env.Events(x,a);
                total_reward = total_reward + r;

                % convert the continous state variables in [xp] to an index of the statelist    
                sp  = RL.Env.DiscretizeState(xp);

                % select action prime
                ap = RL.GetAction(sp);

                % Update the Qtable, that is,  learn from the experience
                feval(RL.MethodFcn,RL,'UpdatePolicy',s, a, r, sp, ap) ;  

                %update the current variables
                s = sp;
                a = ap;
                x = xp;

                %increment the step counter.
                steps=steps+1;

                % Plot of the model
                if RL.grafics        
                   RL.Env.Render(x,a,steps);    
                end

                % if the goal is reached break the episode
                if stop_episode
                    break
                end

            end

        end
        
        % Plot a heat map of Q:
        function [] = PlotQ(RL)
            
          figure(RL.plot_Q_handle)  
          imagesc(Q) 
            
        end

   end
    
    
end