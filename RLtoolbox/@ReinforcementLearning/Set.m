function [] = Set( RL, varargin )
% Sets desired object properties

nParams = (nargin-1)/2;
if rem(nParams,1)~=0 || nargin<1
    error('Set failed: not enough inputs')
else
    for p = 1:nParams
        key = varargin{2*p-1};
        value = varargin{2*p};
%         if ~isnumeric(value)
%             error('Set failed: property value must be numeric');
%         end
        
        switch key

            case 'eps'
                RL.eps = value; 
            case 'eps_decrease'
                RL.eps_decrease = value;
            case 'eps_decrease_val'
                RL.eps_decrease_val = value;  
            case 'alpha'
                RL.alpha = value;
            case 'alpha_decrease'
                RL.alpha_decrease = value;
            case 'alpha_decrease_val'
                RL.alpha_decrease_val = value; 
            case 'gamma'
                RL.gamma = value; 
            case 'max_steps'
                RL.max_steps = value; 
            case 'lambda'
                RL.lambda = value; 
            case 'MethodFcn'
                RL.MethodFcn = value;
            case 'Env'
                RL.Env = value;
            case 'IC'
                RL.IC = value;
            case 'random_IC'
                RL.random_IC = value;
            case 'enable_random_IC'
                RL.enable_random_IC = value;  
            otherwise
                error(['Set failed: ',key,' property not found']);
        end
    end
end

