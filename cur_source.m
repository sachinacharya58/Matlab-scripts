clc;
clear all;
close all;
%%
kp = 80e-6;

vtp = 493e-3;
id = 10.03e-6;

R = vtp/id;

%%
Res = 50e3;
vs = 1.4-100e-3; vg = 0; vtn = 500e-3;
syms beta

mos_R = Res == 1/(kp*beta*(vs-vg-vtp));
beta = double(solve(mos_R,beta));

%%
id = 10e-6;
kp = 80e-6;
kn = 330e-6;

syms beta1;
syms beta2;
syms vsgp;
syms vgsn;
vtp = 498.5e-3; vtn = 420e-3;

mos_I1 = id == kp*beta1*(0.3)^2/2;
mos_I2 = id == kn*beta2*(0.3)^2/2;
mos_I3 = vsgp+vgsn == 1.4;

beta_1 = double(solve(mos_I1,beta1));
beta_2 = double(solve(mos_I2,beta2));

%%
beta = 1;
id = kn*beta*(Vov)^2/2;
fplot(id,[10e-6 300e-6]);