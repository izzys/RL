function [] = RunDP(RL)   

gamma = 0.9;


%Policy evaluation

% the straight forward way:
% sum = 0;
% 
% for k = 0:100
%     
%   a = RL.Agt.GetAction(s0);
%   s(k+1) =  RL.Env.GetNextState(s0,a);
%   r(k+1) = RL.Env.GetReward(s0,a);
%   s0 = s(k+1);
%   sum  = sum + gamma^k*r(k+1);
% 
% end

% iterative way:

theta = 1e-7;
delta = Inf;
k = 1;
while delta>theta
    k
    delta = 0;
    
    for s = RL.Env.S
        
        v = RL.V(s);
        RL.V(s) = RL.Bellmans(s);
        delta = max(delta,abs(v-RL.V(s)));
        
    end
    k = k+1;
    
end
