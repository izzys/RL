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

    RL.delta = 0;
    
    steps = RL.Sdim;

    % Update the Qtable, that is,  learn from the experience
    UpdatePolicy(RL);   
    
    total_reward = RL.delta;
        
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

function [] = BellmansMax(RL,s0)

    g = RL.gamma;
    V = -Inf;
    
    for a = 1:length(RL.Env.A)

        x = RL.Env.S(s0,:);
        x_next = RL.Env.GetNextState(x,a);
        s_next = RL.Env.DiscretizeState(x_next);

        
        Vnext = RL.V(s_next);
        R = RL.Env.GetReward(RL.Env.S(s0,:),a);
        Rp = R+g*Vnext;

        if Rp>=V
            V = Rp;
            a_max = a;
        end

    end
    
    RL.V(s0) = V;

    RL.Q(:,s0) = ones(RL.Adim,1)*(-9999);
    RL.Q(a_max,s0) = V;
