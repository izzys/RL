classdef ReinforcementLearning < handle
 
    properties 
        
        Method; 
        Env;
        gamma;
        alpha;
        eps;
        lambda;
        
        V;
        Q;
        
        maxsteps ;
        grafics;
        
    end
    
    methods
        
        function [RL] = ReinforcementLearning(method,environment)
             RL.Method = method;
             RL.Env = environment;
        end
        
        function [] = Init(RL,varargin)
            
            RL.Env.Init();
                        
            RL.V = zeros(1,RL.Env.Sdim);
            RL.Q = zeros(RL.Env.Adim,RL.Env.Sdim);
            
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
        
        function [total_reward,steps] = Episode(RL)

            % state variables x,x_dot,theta,theta_dot
            x            = [0 0 0 0.01];
            steps        = 0;
            total_reward = 0;

            % convert the continous state variables to an index of the statelist:
            s   = RL.Env.DiscretizeState(x);
            % selects an action using the current strategy:
            a   = RL.EgreedySelection(s);

            max_k = RL.maxsteps;
            
            for k=1:max_k    

                % convert the index of the action into an action value
%                 action = actionlist(a);    

                %do the selected action and get the next car state    
                xp  = RL.Env.GetNextState( x , a  );    

                % observe the reward at state xp and the final state flag
                [r]   = RL.Env.GetReward(x,a);
                stop_episode = RL.Env.Events(x,a);
                total_reward = total_reward + r;

                % convert the continous state variables in [xp] to an index of the statelist    
                sp  = RL.Env.DiscretizeState(xp);

                % select action prime
                ap = RL.EgreedySelection(sp);

                % Update the Qtable, that is,  learn from the experience
                RL.UpdateSARSA( s, a, r, sp, ap);

                %update the current variables
                s = sp;
                a = ap;
                x = xp;

                %increment the step counter.
                steps=steps+1;

                % Plot of the mountain car problem
                if RL.grafics        
                   RL.Env.Render(x,a,steps);    
                end

                % if the car reachs the goal breaks the episode
                if stop_episode
                    break
                end

            end

        end
        
        
        function [ ] = UpdateSARSA( RL , s, a, r, sp, ap  )
                % UpdateQ update de Qtable and return it using Whatkins QLearing
                % s1: previous state before taking action (a)
                % s2: current state after action (a)
                % r: reward received from the environment after taking action (a) in state
                %                                             s1 and reaching the state s2
                % a:  the last executed action
                % tab: the current Qtable
                % alpha: learning rate
                % gamma: discount factor
                % Q: the resulting Qtable

                Q = RL.Q;
                RL.Q(a,s) =  Q(a,s) + RL.alpha * ( r + RL.gamma*Q(ap,sp) - Q(a,s) );
                
        end
       
        
        function [ ap ] =  EgreedySelection(RL,sp)
        
            actions = RL.Env.Adim;

            if (rand()>RL.epsilon) 
                ap = RL.Agt.GetBestAction(sp);    
            else
                % selects a random action based on a uniform distribution
                % +1 because randint goes from 0 to N-1 and matlab matrices goes from
                % 1 to N
                ap = randint(1,1,actions)+1;
            end

        end
        
    end
end