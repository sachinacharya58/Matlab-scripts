clc;
close all;
clear all;

%% 
gmp = 10e-6;
gmn = 10e-3;
id = 20e-3;
Vsup = 3.6; Vtn = 0.758;Vs = 0.165;

syms betap betan
eqn0 = 2*id == 100e-6*betap*((0.1)^2);
%eqn1 = gmp == 30e-6*betap*(Vsup-Vtn);
eqn2 = gmn == 100e-6*betan*(Vsup-Vtn);

betap = double(solve(eqn0,betap));
betan = double(solve(eqn2,betan));


%% 
syms R1 R2
vref = 0.9;
Vdd = 14;
R1 = 1e6;
eqn1 = vref == Vdd*R2/(R1+R2);

R2 = double(solve(eqn1,R2));


%%
vdd = 1.5; t = 1e-6;
slope1 = vdd/t; slope2 = vdd/(t/2);

t1 = (1e-6)-(.36e-6);
y1 = slope1*t1; y2 = slope2*t1/21;

%% Nested miller pole location
Gain_dB = 153;
Gain = 10^(153/20);
gm1 = 3e-3; gm2 = 4e-3; gm3 = 5e-3;
R = (Gain/(gm1*gm2*gm3)).^ (1/3);
Cl = 50e-12; Cm2 = 333e-12; Cm1 = 133e-12;
zeta = 1/sqrt(2);
GBW = gm3/Cm2;
p23 = gm1/(sqrt(2)*Cl);
GBpole = (2*zeta*GBW/p23)/(1- ((GBW/p23).^2));
PM = 90 - atand(GBpole);

