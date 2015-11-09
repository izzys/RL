function [] = InitMonteCarlo(RL,SubMethod)   

RL.Init();

% init policy:

switch SubMethod
    
    case 'OnPolicy'

        RL.Agt.Eps = 0.1;

        for s = 1:RL.Env.Sdim

            Pi(s).a_opt = 1;
            Pi(s).P(1) = 1-RL.Agt.Eps+RL.Agt.Eps/RL.Env.Adim;
            Pi(s).P(2:RL.Env.Adim) = RL.Agt.Eps/RL.Env.Adim;
            Pi(s).A = RL.Env.A;
            Pi(s).A_id = 1:RL.Env.Adim;

        end

        RL.Agt.SetPolicy(Pi);

    case 'ES'
        


        for s = 1:RL.Env.Sdim

            Pi(s).P = [0.25 0.25 0.25 0.25];
            Pi(s).A = RL.Env.A;
            Pi(s).A_id = 1:RL.Env.Adim;

        end

        RL.Agt.SetPolicy(Pi);    

    otherwise
        
        error('ERROR: Monte Carlo sub-method not defined')
        
end