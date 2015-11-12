function [ RL ] = Set( RL, varargin )
% Sets desired object properties

nParams = (nargin-1)/2;
if rem(nParams,1)~=0 || nargin<1
    error('Set failed: not enough inputs')
else
    for p = 1:nParams
        key = varargin{2*p-1};
        value = varargin{2*p};
        if ~isnumeric(value)
            error('Set failed: property value must be numeric');
        end
        
        switch key

            case 'eps'
                RL.eps = value; 
            case 'alpha'
                RL.alpha = value; 
            case 'gamma'
                RL.gamma = value; 
            case 'max_steps'
                RL.max_steps = value; 
            case 'lambda'
                RL.lambda = value; 

            otherwise
                error(['Set failed: ',key,' property not found']);
        end
    end
end

