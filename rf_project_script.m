%% Matlab  code for frequency transformation for Dual-Band LNA
    % Need to find Cp, Lp, Ls, Cs, Cg, Ldeg on the input side
    % Cres, Lres, Cn, Ln on the output side
    
 %% Low pass transfer function of 1/(s+a)
 clc;
 close all;
 clear all;
 w = 1e-3:1e-3:10;
 lpf = tf(1,[1 0.1]);
 
 w = 1e-3;
 syms wt
 map_freq = wt^2 - w*wt - 0.1^2 == 0;
 S = solve(map_freq)
 root = double(S)
 %bode(lpf,w);
 
 %% To deetermine wm, a2
 clc;
close all;
clear all;

f1 = 800e6;
f2 = 1.6e9;
w1 = 2*pi*f1;
w2 = 2*pi*f2;

syms wm;
syms a2;
eqn1 = w1^2 - w1/(a2*wm) + (1/a2) == 0
eqn2 = w2^2 + w2/(a2*wm) + (1/a2) == 0;

SOLN = solve (eqn1,eqn2);

a2 = double(SOLN.a2);
wm = double(SOLN.wm);

% Comparing a2,wm with paper equation
a2_p = -1/(w1*w2);
wm_p = 1/(a2_p*(w1-w2));

%% Component values Lg, L1, C1, Cgs
Cgs = 0.3e-12;
Lg = 1/(wm^2*Cgs); 

syms L1;
syms C1;

eqn3 = wm - wm*(w2^2)*Cgs*L1 == -w2
% eqn4 = 1/(1i*wm*Lg)   == 1/(1i*w1*Lg)  + (1i*w1*C1) ;
eqn4 = wm - wm*(w1^2)*C1*Lg == w1

COMP_VALUES1 = solve(eqn3,L1);
COMP_VALUES2 = solve(eqn4,C1);
L_1 = double(COMP_VALUES1);
C_1 = double(COMP_VALUES2);

Rs = 50;
gm = 10e-3;
wt = gm/Cgs;

Ls = Rs/wt;

% Input impedance
s = tf('s');
Zin = 1/(1/(s*Lg) + s*C_1) + s*L_1 + 1/(s*Cgs) + Rs;
% freq rnage
wrng = -2*pi*2e9:(2*pi*2e9)/10000:2*pi*2e9;
bode(Zin)