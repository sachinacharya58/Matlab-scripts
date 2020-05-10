clc;
close all;
clear all;

%% 2nd stage need to have higher GBW than overall GBW
% Designing the second stage for GBW = 10MHz
GBW2 = 2*pi*5e6;
CL = 30e-12;

gm2 = GBW2*CL;
RL = 10e3;
Av2 = gm2*RL;
% Current required for an overdrive of 100mV
Vov0 = 0.1;
ID = gm2*Vov0/2;

syms betan2
kn = 200e-6;
mos_M2 = ID == kn*betan2*Vov0^2;
betan2 = double(solve(mos_M2,betan2));

syms betap2
kp = 50e-6;
mos_M2 = ID == kp*betap2*Vov0^2;
betap2 = double(solve(mos_M2,betap2));

%% INPUT PMOS pair
ID = 40e-6;
Vov1 = 0.1;
kp = 50e-6;

syms betap1
mos_M2 = ID == kp*betap1*Vov1^2;
betap1 = double(solve(mos_M2,betap1));

gm1 = 2*ID/Vov1;

%% Output resistance

CMRR = 65;
CMRR_AV = 10^(CMRR/20);

% ID determination
syms ID RO

gm = 1e-3;
lambda = 0.2;

mos_R1 = CMRR_AV == 1+gm*RO;

RO = double(solve(mos_R1,RO));

mos_R2 = RO == 1/(lambda*ID);

ID = double(solve(mos_R2,ID));

