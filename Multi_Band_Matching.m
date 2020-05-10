% Script contains code for the realizing a multi-band frequency
% transformation circuit
clear, clc;
%% Choice of the Degeneration Innductor
% wt * Ls = 50ohms
gm = 10e-3; % starting off with a gm of 10m A/v^2 (subject to change)
Cgs = 300e-15; % starting off with a Cgs (subject to change)
wt = gm / Cgs;
Ls = 50 / wt; %% valueof the degeneranation inductor

%%
% defining the system
f1 = 0.8e9;
f2 = 1.6e9;
w1 = 2*pi*f1;
w2 = 2*pi*f2;
syms wm; % frequency variables
syms a2; % quadratic equation constant
syms C1 L1; % unknown components
% extracting the system variables given the resonant points
eqn1 = (w1^2) - (w1 / (a2*wm)) + (1/a2) == 0;
eqn2 = (w2^2) + (w2 / (a2*wm)) + (1/a2) == 0;
sys = solve(eqn1,eqn2);
a2 = double(sys.a2);
wm = double(sys.wm)

%%
% selecting a Ceq = Cgs + Cext
Cext = 9e-12;
Ceq = Cgs + Cext;
Lg = 1 / (Ceq*(wm^2));

%%

%obtaining L1 from Ceq
eqn3 = wm - wm*(w2^2)*Ceq*L1 == -w2
L1 = double(solve(eqn3,L1))

%%
% obtaining Lg from C1
eqn4 = 1 - (w1^2)*Lg*C1 == -wm*w1*(Lg^2)
C1 = double(solve(eqn4,C1));

%% Constructing the input transfer function
s = tf('s');
R = 50; 
Zin = ((s*Lg/C1*s)/(Lg*s + 1/C1*s)) + L1*s + R + 1/(s*Cgs) + 50
bode(Zin)

