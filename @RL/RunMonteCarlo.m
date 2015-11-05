function [] = RunMonteCarlo(RL,SubMethod)   


switch SubMethod
    
    case 'OnPolicy'
    
        max_k = 500;
        max_episodes = 1000;
        gamma = 0.9;
        
        R.value = cell(RL.Agt.Adim,RL.Env.Sdim,max_episodes);
        R.first_visit = ones(RL.Agt.Adim,RL.Env.Sdim,max_episodes);
        
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
               Ep(episode).R(k) = r;
               
               s0 = s_next;
               
             end

             % Analyse episode: 
             
             % get returns:

               
              for k = 1:max_k
                  
                s = Ep(episode).S(k);
                a = Ep(episode).A(k);
                
                if R.first_visit(a,s,episode)

                    R.value{a,s,episode} = gamma.^[0:(max_k-k)]*Ep(episode).R(k:max_k)';
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
        
        max_k = 100;
        max_episodes = 10000;
        gamma = 0.9;
        
        R.value = cell(RL.Agt.Adim,RL.Env.Sdim,max_episodes);
        R.first_visit = ones(RL.Agt.Adim,RL.Env.Sdim,max_episodes);

        for episode = 1:max_episodes
        episode

             % Generate epsiode:
             
             s0 = randi(RL.Env.Sdim);
             
             for k =  1:max_k

               a = RL.Agt.GetAction(s0);
               if k==1
                   a = RL.Env.A{randi(RL.Agt.Adim)};
               end
               a_id = find(strcmp(RL.Env.A,a),1,'first');
               s_next =  RL.Env.GetNextState(s0,a);
               r =  RL.Env.GetReward(s0,a);
               
               Ep(episode).S(k) = s0;
               Ep(episode).A(k) = a_id;
               Ep(episode).R(k) = r;
               
               s0 = s_next;
               
             end

             % Analyse episode: 
             
             % get returns:

               
              for k = 1:max_k
                  
                s = Ep(episode).S(k);
                a = Ep(episode).A(k);
                
                if R.first_visit(a,s,episode)

                    R.value{a,s,episode} = gamma.^[0:(max_k-k)]*Ep(episode).R(k:max_k)';
                    R.first_visit(a,s,episode) = 0;
                    
                    % avarage returns:  
                    RL.Q(a,s)  = mean(cell2mat( R.value(a,s,:) ) );    
                end
                  
              end
              
              
               n= norm(   RL.Q   )  ;
               Qnorm(episode) = n;     
               
              % Get optimal policy:
              
              for s = RL.Env.S
              
                  [ ~, i ] = max(RL.Q(:,s));

                   RL.Agt.Policy(s).P(i) = 1;
                   RL.Agt.Policy(s).P([1:(i-1) , (i+1):RL.Agt.Adim ] ) = 0;

              end

            
              

        end
        
        plot(Qnorm,'r')
        
        
    otherwise
        
        error('ERROR: Monte Carlo sub-method not defined')
        
end
 