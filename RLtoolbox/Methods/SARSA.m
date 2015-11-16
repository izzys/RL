function varargout = SARSA(RL,varargin)


if nargin && ischar(varargin{1})
    method_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = method_Callback(RL, varargin{2:end});
else
    method_Callback(RL, varargin{2:end});
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
    ap = varargin{5}; 
    
    Q = RL.Q;
    RL.Q(a,s) =  Q(a,s) + RL.alpha * ( r + RL.gamma*Q(ap,sp) - Q(a,s) );

