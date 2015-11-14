function varargout = SARSA(RL,varargin)


if nargin && ischar(varargin{1})
    method_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = method_Callback(RL, varargin{:});
else
    method_Callback(RL, varargin{:});
end

    
function [a] = GetBestAction(RL,varargin)   

s = varargin{2};

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

function [ ] = UpdatePolicy( RL , s, a, r, sp, ap  )
        % UpdateQ update de Qtable and return it using Whatkins QLearing
        % s1: previous state before taking action (a)
        % s2: current state after action (a)
        % r: reward received from the environment after taking action (a) in state
        %                                             s1 and reaching the state s2
        % a:  the last executed action
        % tab: the current Qtable
        % alpha: learning rate
        % gamma: discount factor
        % Q: the resulting Qtable

        Q = RL.Q;
        RL.Q(a,s) =  Q(a,s) + RL.alpha * ( r + RL.gamma*Q(ap,sp) - Q(a,s) );

end