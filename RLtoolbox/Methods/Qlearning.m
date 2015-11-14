function varargout = Qlearning(RL,varargin)


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