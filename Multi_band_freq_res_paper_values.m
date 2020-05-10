% Script contains code for the realizing a multi-band frequency - values
% from research paper
%%
% transformation circuit
clear, clc;
s = tf('s');

%%
% defining the system
Rs_in = 50;
f1 = 0.8e9;
f2 = 1.6e9;
w1 = 2*pi*f1;
w2 = 2*pi*f2;
syms wm; % frequency variables
syms a2; % quadratic equation constant
syms Lg C1; % component values
% extracting the system variables given the resonant points
eqn1 = (w1^2) - (w1 / (a2*wm)) + (1/a2) == 0;
eqn2 = (w2^2) + (w2 / (a2*wm)) + (1/a2) == 0;
sys = solve(eqn1,eqn2);
a2 = double(sys.a2);
wm = double(sys.wm);
fm = wm/(2*pi);

%%
%Compensation for a gate-source capacitance of 7pF
Cgs = 7e-12;
% resonating Ls with Cgs @ wm
Ls = 1 / (Cgs*(wm^2))

%% Constructing the impedance equation

Zin = 50 + Ls*s + 1/(Cgs*s);
%bode(Zin)

%%
%obtaining L1 from Cgs
eqn3 = 1 - (w2^2)*Lg*Cgs == -(w2/wm)
%eqn3 = wm - wm*(w1^2)*Cgs*Lg == w1
Lg = double(solve(eqn3,Lg))

%%
% obtaining Lg from C1
%eqn4 = 1 - (w2^2)*Lg*C1 == +wm*w2*(Lg^2);
eqn4 = 1 - (w1^2)*Ls*C1 == (w1/wm)
C1 = double(solve(eqn4,C1))

%%
% Reconstruting the transformed impedance 
Zin_rec = Rs_in + (1/(s*Cgs)) + s*Lg + (s*Ls/((s^2)*Ls*C1)+1)
bode(Zin_rec)
mag_wp1 = abs((freqresp(Zin_rec,w1)))
mag_wp2 = abs((freqresp(Zin_rec,w2)))
mag_wpm = abs((freqresp(Zin_rec,wm)))

