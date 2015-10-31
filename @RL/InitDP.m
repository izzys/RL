function [] = InitDP(RL)   

RL.Init();

% init policy:
for s = 1:RL.Env.Dim
    Pi(s).P = [ 0.25 0.25 0.25 0.25];
    Pi(s).A = RL.Env.A;
    Pi(s).A_id = 1:4;
end


RL.Agt.SetPolicy(Pi);