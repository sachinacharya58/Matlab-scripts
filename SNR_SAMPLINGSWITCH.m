clc; 
close all;
clear all;

%%

vp = 200e-3;
k = 1.3807e-23;
T = 300;

syms C

SNR = 60 == 10*log10(((vp/sqrt(2))^2)/(k*T/C));

C = double(solve(SNR,C));

%%
syms R

BW = 2*pi*20e6 == 1/(R*C);
R = double(solve(BW,R));

