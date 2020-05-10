clc;
close all;

%% LNA input impedance match

R1 = 262.8, Cgs = 87.2e-15, Cgd = 1.374e-15, gm = 5.896e-3, L1 = 1e-9, Lg = 22.5e-9;
s = tf('s');
num = (R1 + (1/(Cgd*s)))*(L1*Cgs*s^2 + gm*L1*s + 1);
den = (L1*Cgs*s^2 + R1*Cgs*s + gm*L1*s + gm*R1 + Cgs/Cgd + 1);

Z = num/den;
w = 2*pi*1.9e9;
matching_imp = freqresp(Z,w)