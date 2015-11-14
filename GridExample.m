 clc;close all;clear classes;

RL = ReinforcementLearning(MonteCarlo(),GridWorld());

RL.Env.WorldType = 'AB'; %ZeroStart

RL.InitGridWorldDP();
RL.RunStochasticDP();

% RL.InitMonteCarlo('ES');
% RL.RunMonteCarlo('ES');