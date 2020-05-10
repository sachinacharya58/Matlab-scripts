clc;
close all;
clear all;

%%
gm = 1e-3;
Vov = 0.07;
Ibias = gm*Vov;
syms betain3
eqn = gm == 270e-6*betain3*Vov;
betain3 = double(solve(eqn,betain3));

%%
Id = 385e-6;
syms betap
eqn = Id == 40e-6*betap*((0.1)^2);

betap = double(solve(eqn,betap));

%% SNR for 9.5 bits
ENOB = 9.5;
SNR = 6.02*ENOB + 1.76;
vni = (1/8)/(10^(SNR/10));
