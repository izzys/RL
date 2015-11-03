function [] = RunMonteCarlo(RL,SubMethod)   


switch SubMethod
    
    case 'OnPolicy'
    
        max_k = 90;
        max_episodes = 100;
        gamma = 0.9;

        for episode = 1:max_episodes
        episode

             % Generate epsiode:
             
             s0 = randi(RL.Env.Sdim);
             
             for k =  1:max_k

               a = RL.Agt.GetAction(s0);
               a_id = find(strcmp(RL.Env.A,a),1,'first');
               s_next =  RL.Env.GetNextState(s0,a);
               r =  RL.Env.GetReward(s0,a);
               
               Ep(episode).S(k) = s0;
               Ep(episode).A(k) = a_id;
               Ep(episode).Snext(k) = s_next;
               Ep(episode).R(k) = r;
               
               s0 = s_next;
               
             end

             % Analyse episode: 
             
             % ger returns:
              R.value = cell(RL.Agt.Adim,RL.Env.Sdim,max_episodes);
              R.first_visit = ones(RL.Agt.Adim,RL.Env.Sdim,max_episodes);
               
              for k = 1:max_k
                  
                s = Ep(episode).S(k);
                a = Ep(episode).A(k);
                
                if R.first_visit(a,s)

                    R.value{a,s,episode} = gamma.^[(k-1):(max_k-1)]*Ep(episode).R(k:max_k)';
                    R.first_visit(a,s,episode) = 0;
                    
                    % avarage returns:  
                    RL.Q(a,s)  = mean(cell2mat( R.value(a,s,:) ) );    
                end
                  
              end
                            
              % Get optimal policy:
              
              for s = RL.Env.S
              
              [ ~, i ] = max(RL.Q(:,s));
 
               RL.Agt.Policy(s).a_opt = i;
               RL.Agt.Policy(s).P(i) = 1-RL.Agt.Eps+RL.Agt.Eps/RL.Agt.Adim;
               RL.Agt.Policy(s).P([1:(i-1) , (i+1):RL.Agt.Adim ] ) = RL.Agt.Eps/RL.Agt.Adim;

              end

            


        end



    case 'ES'% Exploring starts Monte Carlo:
        
        max_k = 90;
        max_episodes = 100;
        R.values = cell(RL.Agt.Adim,RL.Env.Sdim,max_episodes);
        R.visited = zeros(RL.Agt.Adim,RL.Env.Sdim,max_episodes);
        gamma = 0.9;
        
        for episode = 1:max_episodes
        episode

            for s = RL.Env.S

                 sumR = 0;
                 s0 = s;
                 for k =  1:max_k

                   a = RL.Agt.GetAction(s0);
                   if k == 1
                       a = RL.Env.A{randi(RL.Agt.Adim)};
                       a_id = find(strcmp(RL.Env.A,a),1,'first');
                   end
                   s_next =  RL.Env.GetNextState(s0,a);
                   r =  RL.Env.GetReward(s0,a);
                   s0 = s_next;
                   sumR  = sumR + gamma^(k-1)*r;

                 end


                 R.values{a_id,s,episode} = sumR;  % assign reward for using action 'a_id' to state s0
                 RL.Q(a_id,s)  = mean(cell2mat( R.values(a_id,s,:) ) );
               
                 [ ~, i_max ] = max(RL.Q(:,s));
                 
                 RL.Agt.Policy(s0).P = zeros(1,length(RL.Agt.Policy(s0).P));
                 RL.Agt.Policy(s0).P(i_max) = 1;
                 
            end


        end
        
        
        
    otherwise
        
        error('ERROR: Monte Carlo sub-method not defined')
        
end
 