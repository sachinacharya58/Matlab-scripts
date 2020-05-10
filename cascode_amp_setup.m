

clc;
close all;
clear all;

Id = 100e-6; 

Vov1 = 0.15;
Vov2 = 0.15;
Vov3 = 0.15;
Vov4 = 0.15;

%% MOS current equation
% Id = uCoxW/L * Vov^2 / 2

kp = 70e-6; kn = 270e-6; Vt = 0.45; Vdd = 1.8;

syms beta1 beta2 beta3 beta4

mos_3 = Id == kp*beta3*Vov3^2/2;
mos_4 = Id == kp*beta4*Vov4^2/2;
mos_2 = Id == kn*beta2*Vov2^2/2;
mos_1 = Id == kn*beta1*Vov1^2/2;

beta1 = double(solve(mos_1,beta1));
beta2 = double(solve(mos_2,beta2));
beta3 = double(solve(mos_3,beta3));
beta4 = double(solve(mos_4,beta4));

%% Bias voltages
Vb1 = Vov1 + Vov2 + Vt;
Vb2 = Vdd - Vov4 - Vov3 - Vt;
Vb3 = Vdd - Vov4 - Vt;
Vb4 = Vov1 + Vt;