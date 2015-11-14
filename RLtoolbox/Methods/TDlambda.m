function varargout = TDlambda(RL,varargin)


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
a = 1;


function [ ] = UpdatePolicy( RL , s, a, r, sp, ap  )

Q = RL.Q;
RL.Q(a,s) =  Q(a,s) + RL.alpha * ( r + RL.gamma*Q(ap,sp) - Q(a,s) );