function [] = InitCartPole(RL)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RL.Init();

% init policy:
for s = 1:RL.Env.Sdim
    Pi(s).P = ones(1,RL.Env.Adim)/RL.Env.Adim;
    Pi(s).A = RL.Env.A;
    Pi(s).A_id = 1:RL.Env.Adim;
end

RL.Agt.SetPolicy(Pi);

f1 = subplot(2,1,1);
box off

f2 = subplot(2,1,2);

P2 = ['setgrafica();'];
PushBut2=uicontrol(gcf,'Style','togglebutton','Units','normalized', ...
   	'Position',[0.83 .9 0.16 0.05],'string','Graficar', ...
      'Callback',P2,'visible','on','BackgroundColor',[0.8 0.8 0.8]);
set(gcf,'name','Reinforcement Learning with a Scara Manipulator Robot');
set(gcf,'Color','w')

grid off					

set(gco,'BackingStore','off')  % for realtime inverse kinematics
set(gco,'Units','data')

drawnow;
