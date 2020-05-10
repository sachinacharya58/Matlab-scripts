

clc;
close all;
clear all;

kn = 200e-6;
beta = 20;

syms ID VI

mos_I = ID == kn*beta*(VI - ID*10e3 - 0.45)^2;

ID = solve(mos_I,ID)

%%
%VG = 1.8;
Idrain = @(VG) VG./10000 - (160.*VG - 71).^(1/2)/800000 - 7/160000;

x = 0:0.1:1.8;
IX = Idrain(x);
plot(x,IX);
