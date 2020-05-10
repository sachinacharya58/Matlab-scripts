clc;
close all;
clear all;

syms ltot
W = 4e-6;
N = 4;
L = 17.36e-9;
S = 0.5e-6;

eqn = L == 1.3e-7*(ltot^(5/3))/((((ltot/(4*N)) + W + (N-1)*(W+S))^(1/3))*(W^0.083)*(W+S)^0.25);
sol = solve(eqn,ltot)