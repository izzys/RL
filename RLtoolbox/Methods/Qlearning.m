function varargout = Qlearning(RL,varargin)


if nargin && ischar(varargin{1})
    method_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = method_Callback(RL, varargin{2:end});
else
    method_Callback(RL, varargin{2:end});
end

function [total_reward,steps] = RunEpisode(RL,varargin)


        if RL.enable_random_IC
            x  = str2num( RL.Env.random_IC );
        else
            x = RL.Env.const_IC;
        end

        steps        = 0;
        total_reward = 0;

        % convert the continous state variables to an index of the statelist:
        s   = RL.Env.DiscretizeState(x);
        % selects an action using the current strategy:
        a   = RL.GetAction(s);

        RL.StopSim = 0;

        while steps<RL.max_steps  && ~RL.StopSim    

            % do the selected action and get the next state:   
            xp  = RL.Env.GetNextState( x , a  );    

            % observe the reward at state xp
            [r]   = RL.Env.GetReward(x,a);
            stop_episode = RL.Env.Events(x,a);
            total_reward = total_reward + (RL.gamma)^steps*r;

            % convert the continous state variables in [xp] to an index of the statelist    
            sp  = RL.Env.DiscretizeState(xp);
            
            % select action prime
            ap = RL.GetAction(sp);
            
            % Update the Qtable, that is,  learn from the experience
            UpdatePolicy(RL,s,a,r,sp);


            % Plot of the model
            if RL.graphics        
               RL.Env.Render(x,a,steps,RL.plot_model_handle);    
            end


            %update the current variables
            s = sp;
            a = ap;
            x = xp;

            %increment the step counter.
            steps=steps+1;

            % if the goal is reached break the episode
            if stop_episode
                RL.StopSim=1;
            end

        end  
        
        
function [a] = GetBestAction(RL,varargin)   

s = varargin{1};
draw = rand();

if (draw>RL.eps) 
    [~ , a] = max(RL.Q(:,s));   
else
    a = randi(RL.Adim);
end


function [ ] = UpdatePolicy( RL , varargin  )

    s = varargin{1};
    a = varargin{2}; 
    r = varargin{3}; 
    sp = varargin{4}; 
    
    Q = RL.Q;
    RL.Q(a,s) =  Q(a,s) + RL.alpha * ( r + RL.gamma*max( Q(:,sp) )- Q(a,s) );

