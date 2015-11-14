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
        max_episodes = 1e6;
        % value or state-value matrices:
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
        
    end
    
    methods
        
        function [RL] = ReinforcementLearning(varargin)
            
             switch nargin
            
                 case 0
                     %do nothing
                     
                 case 2
                     RL.MethodFcn = str2func( varargin{1} );
                     RL.Env = varargin{2};
             end
        end
        
        function [] = Init(RL,varargin)
                    
            RL.Sdim = RL.Env.Sdim;
            RL.Adim = RL.Env.Adim;
            
            RL.V = zeros(1,RL.Sdim);
            RL.Q = zeros(RL.Adim,RL.Sdim);
              
        end
        
        
        function [a] = GetAction(RL,s)
          
            a = feval(RL.MethodFcn,RL,'GetBestAction',s) ;  
            
        end
        
        function [] = StartLearning(RL,varargin)
           
            
            switch nargin
                case 1
                  plot_learning_handle = figure;  
                case 2
                  plot_learning_handle = varargin{1};
            end

            if isvalid(RL.Env)
                  RL.Init();
            else
                  error('Environment is not loaded')
            end

            xpoints     = [];
            ypoints     = [];

            for i=1:RL.max_episodes    

                [total_reward,steps] = RL.Episode(); 

                disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])

                RL.eps = RL.eps_decrease_val*RL.eps;

                xpoints(i)=i-1;
                ypoints(i)=steps;    

                plot(plot_learning_handle,xpoints,ypoints,'.','Color',[rand(1) rand(1) rand(1)])      
                title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])  
                xlabel('Episodes')
                ylabel('Steps')    
                drawnow

            end
        end

                
        function [total_reward,steps] = Episode(RL)

            RL.Env.Init();
            
            % state variables x,x_dot,theta,theta_dot
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

                %do the selected action and get the next car state    
                xp  = RL.Env.GetNextState( x , a  );    

                % observe the reward at state xp and the final state flag
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
       
        end
    
    
end