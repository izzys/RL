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
                sum_s = R+g*Vnext;
                  
                

%                 sum_s = 0;
%                 for s = 1:length(RL.Env.S)
% 
%                     Vnext = RL.V(s);
%                     
%                     if s==s_next
%                         P = 1;%P(s,s_next,a);
%                     else
%                         P = 0;
%                     end
%                     R = RL.Env.GetReward(s0,action);
%                     sum_s = sum_s + P*( R+g*Vnext );
% 
%                 end

                Pi = RL.Agt.Policy(s0).P(a);
                sum_a = sum_a + Pi*sum_s;
            
            end
                            
            V = sum_a;
            
        end
        
    end
end