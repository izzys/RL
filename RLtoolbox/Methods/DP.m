function varargout = DP(RL,varargin)

if nargin && ischar(varargin{1})
    method_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = method_Callback(RL, varargin{:});
else
    method_Callback(RL, varargin{:});
end

function [total_reward,steps] = RunEpisode(RL,varargin)


            total_reward = [];
            steps = [];


            % Update the Qtable, that is,  learn from the experience
            UpdatePolicy(RL);

            % Plot of the model
%             if RL.graphics        
%                RL.Env.Render(x,a,steps,RL.plot_model_handle);    
%             end


       
        
function [a] = GetBestAction(RL,varargin)   

s = varargin{2};
draw = rand();

if (draw>RL.eps) 
    [~ , a] = max(RL.Q(:,s));   
else
    a = randi(RL.Adim);
end

function [ ] = UpdatePolicy( RL , varargin  )

for s=1:RL.Sdim
  
  v = RL.V(s);
  BellmansMax(RL,s)
  RL.delta = max(RL.delta,abs(v-RL.V(s))) ;
  
  if RL.delta<RL.stopping_criteria
      RL.StopLearning();
      break
  end
      
end

function [V] = Bellmans(RL,s0)

    g = RL.gamma;

    sum_a = 0;
    for a = 1:length(RL.A)

        s_next = RL.Env.GetNextState(s0,a);


        Vnext = RL.V(s_next);
        R = RL.Env.GetReward(s0,action);
        P = R+g*Vnext;


        a = GetBestAction(RL,varargin);

        Pi = RL.Agt.Policy(s0).P(a);
        sum_a = sum_a + Pi*P;

    end

    V = sum_a;

function [] = BellmansMax(RL,s0)

    g = RL.gamma;
    V = -Inf;
    
    for a = 1:length(RL.Env.A)

        s_next = RL.Env.GetNextState(s0,a);

        Vnext = RL.V(s_next);
        R = RL.Env.GetReward(s0,a);
        P = R+g*Vnext;

        if P>=V
            RL.V(s0) = P;
            a_max = a;
        end

    end

    RL.Q(:,s0) = zeros(RL.Adim,1);
    RL.Q(a_max,s0) = 1;
