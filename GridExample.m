clc;close all;clear classes;

RL = RL(DP(),GridWorld());

RL.Env.WorldType = 'AB'; %ZeroStart




RL.InitDP();
RL.RunDP();

% for s=1 : V=Epi = 3.19
% for s=2 : V=Epi = 8.567
% for s=3 : V=Epi = 4.719
% for s=4 : V=Epi = 5.266
% for s=5 : V=Epi = 1.1572
% for s=6 : V=Epi = 1.467
% for s=7 : V=Epi = 3.004
% for s=8 : V=Epi = 2.6020 ??
% for s=13 : V=Epi = 0.57
% for s=20 : V=Epi = -1.22
% for s=25 : V=Epi = -2.144