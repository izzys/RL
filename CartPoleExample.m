 clc;close all;clear classes;

RL = RL(SARSA(),CartPole());

RL.InitCartPole();
RL.RunCartPole();
