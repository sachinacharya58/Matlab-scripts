clc;
close all;
clear all;

%% Opamp
PM = 47;
Rl = 10e3; Cl = 50e-12; wp_dom = 2*pi*8; 
Av0 = 130; UGB = 2*pi*20e6; wp_ndom = 2*UGB; wz = 4*UGB;
A0 = 10^(130/20);
f_pole = 1/(2*pi*Rl*Cl);
atan(UGB/wp_ndom)
PM = 90 - 180*(atan(UGB/wp_ndom) + atan(UGB/wz))/pi;
gm2 = wp_ndom*Cl;
Cc = gm2/wz;
%R1 = 1/(gm2*Rl*Cc*wp_dom);
gm1 = UGB*Cc;
R1 = A0/(gm1*gm2*Rl);
A = gm1*R1*gm2*Rl;

%% CMRR 
CMRR_dB = 100;
CMRR = 10^(CMRR_dB/20);
Rs = CMRR/(2*gm1);
Ri = 10;
gcm = 1/(100*CMRR);

Ccm = 1/(2*pi*100e3*Rs);

%% SR = 10V/us
SR = 10e6; I1 = SR*Cc; I2 = SR*(Cl+Cc);

%% PSRR
syms Vo Vi V1 R1 C1 R1 R2 Rf C1 C2 Cf s gm

eqn1 = (V1-Vo)/(Rf + 1/(s*Cf)) + (V1-Vi)/(R1/(1+s*C1*R1)) == 0
eqn2 = (Vo-V1)/(Rf + 1/(s*Cf)) + (Vo-Vi)/(R2/(1+s*C2*R2)) + gm*(V1-Vi) == 0


%% CMRR
syms Vcm Vi V1 R1 C1 Rf C1 Cf s 
R1 = 10; gm = 1e-6;
R2 = 5e9; C2 = 5e-12;
Rc = 15.915e6; Cc = 100e-15; Req = R1*R2/(R1+R2);
eqn1 = Vcm*(1+ (s*Rc*Cc))/(Rc) + (Vcm-V1)*(1+ (s*Req*C2))/(Req) - gm*Vcm == 0;
V1 = solve(eqn1,V1);

CMRR = (V1-Vcm)/Vcm;
pretty(CMRR)
CMRR_S = sym2tf(CMRR);

A0 = -3.20687e+06;
wp1 = 6.10532e+00; wp2 = 4.03062e+07; wz = -8.02141e+07;
num1 = A0; den1 = [1/wp1 1];
num2 = [1/wz 1]; den2 = [1/wp2 1];
S1 = tf(num1,den1); S2 = tf(num2,den2);
bode((1/CMRR_S)); %*

figure (2);
bode((1/(S1*S2)));

%%
f3dB = (1/(2*pi))*(1/(.1e-12*15.915e6));