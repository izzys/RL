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
        StopLearn;
        StopSim;
        stopping_criteria = 1e-4;
        delta;
        
        % value or state-value matrixes:
        V;
        Q;
        
        % model dimensions:
        Adim;
        Sdim;
        
        % inital conditions for each episode:
        enable_random_IC;
        
        % graphics:
        graphics;
        plot_learning_handle;
        plot_Q_handle;
        plot_model_handle;
        LearnPlotColor;
        
        PlotObj;
        
        Xpoints;
        Ypoints;
        
        InitDone = 0;
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
            
            RL.Env.Init();
                        
            RL.Sdim = RL.Env.Sdim;
            RL.Adim = RL.Env.Adim;
            
            RL.V = zeros(1,RL.Sdim);
            RL.Q = zeros(RL.Adim,RL.Sdim);
            
            RL.StopLearn = 0;
            
            RL.Xpoints     = [];
            RL.Ypoints     = [];
            
            RL.InitDone = 1;
            RL.delta = 0;
            
            % Init plots:
            set(RL.plot_Q_handle,'XTick',[],...
                                 'YTick',[],... 
                                 'XTickLabel',[],... 
                                 'YTickLabel',[]);
            colormap(RL.plot_Q_handle, 'Jet')
           
            RL.LearnPlotColor = [rand() rand() rand()];
          
            RL.PlotObj.curve = plot(RL.plot_learning_handle,0,0,'Color',RL.LearnPlotColor)  ; 
            
            RL.PlotObj.title = title(RL.plot_learning_handle,'Episode:       epsilon:        alpha:')  ;
            
            xlabel(RL.plot_learning_handle,'Episodes')
            ylabel(RL.plot_learning_handle,'Reward')    
            
        end
          
        % Start and run the learning process:
        function [] = StartLearning(RL,varargin)
           
           
            if (nargin== 1) %RL is used without GUI
                  RL.plot_learning_handle = figure; 
                  RL.plot_Q_handle = figure;
                  RL.plot_model_handle = figure;
            end

            if isvalid(RL.Env)  % Run RL only if a environment is loaded
                  RL.Init();
            else
                  error('Environment is not loaded')
            end
           
            episode=1;
            RL.delta = Inf;
            
            while episode<=RL.MaxEpisodes && ~RL.StopLearn  && (RL.delta>RL.stopping_criteria) 

                RL.delta = 0;
                
                [total_reward,steps] = RL.Episode(); 

                disp(['Espisode: ',int2str(episode),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(RL.eps)])

                if RL.eps_decrease
                    RL.eps = RL.eps_decrease_val*RL.eps;
                end
                    
                if RL.alpha_decrease
                    RL.alpha = RL.alpha_decrease_val*RL.alpha;
                end
                 
                RL.PlotLearningCurve(episode,total_reward,steps)
                
                episode = episode+1;

            end
        end
        
        % Stop the learning process:
        function [] = StopLearning(RL)
            
            RL.StopLearn=1;
            RL.StopEpisode()
            
        end
        
        % Get action for next step - based on current policy:
        function [a] = GetAction(RL,s)
          
            if isempty(RL.MethodFcn)
                
            %    disp('maybe this? No policy has been learned. using random actions')
                a = randi(RL.Env.Adim);
                
            else
                
                a = feval(RL.MethodFcn,RL,'GetBestAction',s) ;
        

            end
            
            
        end
        
        function [] = UpdatePolicy(RL,s,a,r,sp,ap)
           
           if isempty(RL.MethodFcn)         
         %       disp(' No method has been chosen. No policy is updated.')            
           else  
                feval(RL.MethodFcn,RL,'UpdatePolicy',s,a,r,sp,ap) ;  
           end
            
        end
        
        % An episode runs for #steps or until the goal is reached:
        function [total_reward,steps] = Episode(RL)
  
            if ~RL.InitDone
                RL.Init();
            end
            
            RL.Env.Init();
            
            [total_reward,steps] = feval(RL.MethodFcn,RL,'RunEpisode') ;
               
        end
        
        % Stop the episode;
        function [] = StopEpisode(RL)
            
            RL.StopSim=1;
            
        end
        
        % Plot a heat map of Q:
        function [] = PlotLearningCurve(RL,episode,total_reward,steps)
            
%           RL.Xpoints(episode)=episode;
%           RL.Ypoints(episode)=total_reward;    
% 
%           set(RL.PlotObj.curve,'Xdata',RL.Xpoints,'Ydata',RL.Ypoints)  
%           set(RL.PlotObj.title,'String',['Episode: ',int2str(episode),'  epsilon: ',num2str(RL.eps) , '  alpha: ' num2str(RL.alpha)]) 
%           drawnow
          
          
          axes(RL.plot_Q_handle)  
          imagesc(RL.Q)     
          set(RL.plot_Q_handle,'XTick',[],...
                               'YTick',[],... 
                               'XTickLabel',[],... 
                               'YTickLabel',[]);
          drawnow
          
        end
        
        % Clear the heat map of Q:
        function [] = ClearLearningCurve(RL)
            
            cla(RL.plot_Q_handle)
            cla(RL.plot_learning_handle )
            RL.Init();
            
          
        end
   end
    
    
end