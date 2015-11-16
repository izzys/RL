function varargout = DP(RL,varargin)

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
labels = RL.Policy(s).A_id;
probabilities = Agt.Policy(s).P;

% cumulative distribution
cp = [0 cumsum(probabilities)];

%Draw point at random according to probability density
draw = rand();
higher = find(cp >= draw==1,1);
drawn_a_id = labels(higher-1); 

a = RL.Policy(s).A_id(drawn_a_id);

function [V] = Bellmans(RL,varargin)

    g = RL.gamma;

    sum_a = 0;
    for a = 1:length(RL.Env.A)

        action = RL.Env.A{a};
        s_next = RL.Env.GetNextState(s0,action);


        Vnext = RL.V(s_next);
        R = RL.Env.GetReward(s0,action);
        P = R+g*Vnext;


        a = GetBestAction(RL,varargin);

        Pi = RL.Agt.Policy(s0).P(a);
        sum_a = sum_a + Pi*P;

    end

    V = sum_a;

function [V] = BellmansMax(RL,s0)

    g = RL.gamma;

    V = -Inf;
    for a = 1:length(RL.Env.A)

        action = RL.Env.A{a};
        s_next = RL.Env.GetNextState(s0,action);

        Vnext = RL.V(s_next);
        R = RL.Env.GetReward(s0,action);
        P = R+g*Vnext;

        if P>=V
            V = P;
            a_max = a;
        end

    end

    RL.Agt.Policy(s0).P = zeros(1,length(RL.Agt.Policy(s0).P));
    RL.Agt.Policy(s0).P(a_max) = 1;
