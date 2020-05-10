clc; close all;
clear all;

%% 
syms s
R1 = 487;
R2 = 492;
R3 = 21;
R4 = 48.7e3;
Rs = 13;
C1 = 13e-9;
C2 = 7.5e-9;


Z1 = R3 + 1/(s*C2); Z2 = R1; Z3 = Rs;
Za = Z1*Z2*Z3/(Z1*Z2 + Z2*Z3 + Z3*Z1);
Z4 = R2 + 1/(s*C1); Z5 = R4;
Zb = Z4*Z5/(Z4 + Z5);

beta = Za/(Za + Zb);
A = 1000;

Av = -((Zb/Za)*(1/(1+(A*beta))));
A_s = sym2tf(Av); 
margin(A_s)
