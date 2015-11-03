clc;close all;%clear classes;

RL = RL(MonteCarlo(),GridWorld());

RL.Env.WorldType = 'AB'; %ZeroStart

RL.InitMonteCarlo('OnPolicy');
RL.RunMonteCarlo('OnPolicy');
