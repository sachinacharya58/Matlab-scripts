
clc;
close all;
clear all;

%% Bias currents
id1 = 10e-6;
id2 = 27.5e-6;
id3 = 45e-6;
id4 = 62.5e-6;
id5 = 80e-6;

id = id5;

Vov0 = 0.2;
Vov1 = 0.2;
Vov2 = 0.2;
Vov3 = 0.2;
Vov4 = 0.2;

Vtn0 = 0.6073;
Vtn1 = Vtn0;
Vtn2 = Vtn1;
Vtn3 = 0.5775;
Vtn4 = Vtn3;

Vdd = 1.4;

syms beta0 beta1 beta2 beta3 beta4 
kn = 333.33e-6; kp = 83.33e-6;

mos_M0 = id   == kn*beta0*(Vov0^2)/2;
beta0 = double(solve(mos_M0,beta0));

mos_M1 = id/2 == kn*beta1*(Vov1^2)/2;
beta1 = double(solve(mos_M1,beta1));

mos_M2 = id/2 == kn*beta2*(Vov2^2)/2;
beta2 = double(solve(mos_M2,beta2));

mos_M3 = id/2 == kp*beta3*(Vov3^2)/2;
beta3 = double(solve(mos_M3,beta3));

mos_M4 = id/2 == kp*beta4*(Vov4^2)/2;
beta4 = double(solve(mos_M4,beta4));

%% GBW = 10 MHz
% Accurate calculations need to be done to determine the UGB required
GBW = 2*pi*10e6;
Cl = 10e-12;
gm = GBW*Cl;
%GBW = gm/Cl; fu = GBW/(2*pi);
Vov1 = id/gm;

Vb0 = Vov0 + Vtn0;
Vb1 = Vtn1 + Vov1 + Vov0;
Vb2 = Vov2 + Vtn2 + Vov1 + Vov0;
Vb3 = Vdd - (Vov4 + Vov3 + Vtn3);
Vb4 = Vdd - (Vov4 + Vtn4);

