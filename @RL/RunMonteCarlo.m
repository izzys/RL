function [] = RunMonteCarlo(RL)   


switch SubMethod
    
    case 'OnPolicy'
    
    max_k = 90;
    max_episodes = 1000;
    R = cell(RL.Agt.Adim,RL.Env.Sdim,max_episodes);
    gamma = 0.9;

    for episode = 1:max_episodes
    episode

        for s = RL.Env.S

             sumR = 0;
             s0 = s;
             for k =  1:max_k

               a = RL.Agt.GetAction(s0);
               if k == 1
                   a_id = find(strcmp(RL.Env.A,a),1,'first');
               end
               s_next =  RL.Env.GetNextState(s0,a);
               r =  RL.Env.GetReward(s0,a);
               s0 = s_next;
               sumR  = sumR + gamma^(k-1)*r;

             end


             R{a_id,s,episode} = sumR;  % assign reward for using action 'a_id' to state s0
             RL.Q(a_id,s)  = mean(cell2mat( R(a_id,s,:) ) );
             [ ~, RL.Agt.Policy(s).a_opt ] = max(RL.Q(:,s));

             i=RL.Agt.Policy(s).a_opt;
             RL.Agt.Policy(s).P(i) = 1-RL.Agt.Eps+RL.Agt.Eps/RL.Agt.Adim;
             RL.Agt.Policy(s).P([1:(i-1) , (i+1):RL.Agt.Adim ] ) = RL.Agt.Eps/RL.Agt.Adim;

        end


    end



    case 'ES'% Exploring starts Monte Carlo:
        
    otherwise
        
        error('ERROR: Monte Carlo sub-method not defined')
        
end
 