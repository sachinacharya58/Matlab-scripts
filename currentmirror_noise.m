clc;
close all;
clear all;

%% Current mirror noise

k = 1.38e-23; T = 300; gama = 2/3;
Ro = 100;
gm1 = 215.1e-6; gm2 =226.3e-6; C = 3e-12; tox = 3.74e-9;
KFn = 24e-24; W = 10e-6; L = 4e-6;  E0 = 8.854e-12; Cox = 3.9*E0/tox;

syms f
exp = 1/((gm1^2)+(2*pi*f*C)^2) + (KFn / (W*L*Cox*f)) ;

int_res = double(int(exp,[10 2*pi*20e6]));

op_noise = 4*k*T*gama*gm1*gm2^2*int_res*Ro^2 + (4*k*T*gama*gm2*Ro^2 + 4*k*T*Ro)*20e6;
op_vrms = sqrt(op_noise);

%% Current mirror with R
R = 48.434e3;  C = 3e-12;

Ro = 100;

gm1 = 215.1e-6; gm2 =219.7e-6; C = 3e-12; tox = 3.74e-9;
KFn = 24e-24; W = 10e-6; L = 4e-6;  E0 = 8.854e-12; Cox = 3.9*E0/tox;

syms f
exp =  1/((gm1^2)+ (2*pi*f*C*(1+gm1*R))^2); %(KFn / (W*L*Cox*f)) + 
exp_res = 1/(1 + (2*pi*f*C*R)^2);
int_resgate = double(int(exp,[10 2*pi*1e6]));
int_res = double(int(exp_res,[10 2*pi*1e6]));
op_noise2 = 4*k*T*gama*gm1*gm2^2*int_resgate*Ro^2 + (4*k*T*R*(gm2*Ro)^2 + 4*k*T*gama*gm2*Ro^2 + 4*k*T*Ro)*1e6;
op_vrms2 = sqrt(op_noise2);
