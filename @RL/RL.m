classdef RL < handle
 
    properties 
        
        Agt; 
        Env;
        gamma = 0.9;
        V;
    end
    
    methods
        
        function [RL] = RL(agent,environment)
            RL.Agt = agent;
            RL.Env = environment;
        end
        
        function [] = Init(RL)
            
            RL.Agt.Init();
            RL.Env.Init();
            
            RL.V = zeros(1,RL.Env.Dim);
        end
                
        function [V] = Bellmans(RL,s0)
            
            g = RL.gamma;
            
            sum_a = 0;
            for a = 1:length(RL.Env.A)

                action = RL.Env.A{a};
                s_next = RL.Env.GetNextState(s0,action);
                
                Vnext = RL.V(s_next);
                R = RL.Env.GetReward(s0,action);
                P = R+g*Vnext;
                  
                Pi = RL.Agt.Policy(s0).P(a);
                sum_a = sum_a + Pi*P;
            
            end
                            
            V = sum_a;
            
        end
        
        function [V] = BellmansMax(RL,s0)
            
            g = RL.gamma;
            
            V = -Inf;
            for a = 1:length(RL.Env.A)

                action = RL.Env.A{a};
                s_next = RL.Env.GetNextState(s0,action);
                
                Vnext = RL.V(s_next);
                R = RL.Env.GetReward(s0,action);
                P = R+g*Vnext;
                 
                if P>=V
                    V = P;
                    a_max = a;
                end
                    
            end
            
            RL.Agt.Policy(s0).P = zeros(1,length(RL.Agt.Policy(s0).P));
            RL.Agt.Policy(s0).P(a_max) = 1;
        end
        
    end
end