function [] = RunCartPole(RL)

%maxepisodes: maximum number of episodes to run the demo

maxsteps    = 1000;              % maximum number of steps per episode
statelist   = RL.Env.S;  % the list of states
actionlist  = RL.Env.A; % the list of actions
maxepisodes = 1000;

xpoints     = [];
ypoints     = [];

for i=1:maxepisodes    
    
    [total_reward,steps] = RL.Episode(); 
    
    disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(RL.epsilon)])
    
    RL.epsilon = RL.epsilon * 0.99;
    
    xpoints(i)=i-1;
    ypoints(i)=steps;    
    subplot(2,1,2);    
    plot(xpoints,ypoints)      
    title(['Episode: ',int2str(i),' epsilon: ',num2str(RL.epsilon)])  
    xlabel('Episodes')
    ylabel('Steps')    
    drawnow
    
end

