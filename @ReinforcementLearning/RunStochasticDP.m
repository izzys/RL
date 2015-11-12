function [] = RunStochasticDP(RL)   


% Value iteration, finding optimal Pi:
theta = 1e-7;
delta = Inf;
k = 1;
while delta>theta
    k
    delta = 0;
    
    for s = RL.Env.S
        
        v = RL.V(s);
        RL.V(s) = RL.BellmansMax(s);
        delta = max(delta,abs(v-RL.V(s)));
        
    end
    k = k+1;
    
end
 



