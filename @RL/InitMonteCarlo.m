function [] = InitMonteCarlo(RL)   

RL.Init();

% init policy:

switch SubMethod
    
    case 'OnPolicy'
RL.Agt.Adim = length(RL.Env.A);
RL.Agt.Eps = 0.1;

for s = 1:RL.Env.Sdim
    
    Pi(s).a_opt = 1;
    Pi(s).P(1) = 1-RL.Agt.Eps+RL.Agt.Eps/RL.Agt.Adim;
    Pi(s).P(2:RL.Agt.Adim) = RL.Agt.Eps/RL.Agt.Adim;
    Pi(s).A = RL.Env.A;
    Pi(s).A_id = 1:RL.Agt.Adim;
    
end

RL.Agt.SetPolicy(Pi);

    case 'ES'
        
    otherwise
        
        error('ERROR: Monte Carlo sub-method not defined')
        
end