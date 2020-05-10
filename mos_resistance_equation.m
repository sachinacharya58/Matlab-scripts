clc;
close all;
clear all;

% MOS resistance

syms beta

res = 38.42e3; Vg = 1.8; Vs = 0.2; Vt = 0.6;kn = 100e-6;
mos_R = res == 1/(kn*beta*(Vg-Vs-Vt));

% res = 38.42e3; Vg = 1.8; Vs = 0.2; Vt = 0.5;kp = 100e-6;
% mos_R = res == 1/(kp*beta*(Vs-Vg-Vt));

beta = double(solve(mos_R,beta));
%%
min_w = 120e-9; 
% therefore
L = min_w/beta;