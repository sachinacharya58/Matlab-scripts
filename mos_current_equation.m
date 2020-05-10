clc;
close all;
clear all;

%%
kn = 120e-6;
kp = 40e-6;

% mos current equation
% id = kn* beta * Vov^2 / 2
Vtp = 0.4054;
Vtn = 1;
id = 80e-6;
Vovp = 0.5;
Vovn = 0.25;

%syms Vovp;1.66+


syms betan;
syms betap;
mos_N = id == kn* betan * Vovn^2 / 2;
mos_P = id == kp* betap * Vovp^2 / 2;

betan = double(solve(mos_N,betan));
betap = double(solve(mos_P,betap));

3.6%%
Res = 10;
kn = 333.33e-6;
vs = 500e-3; vg = 1.4; vtn = 500e-3;
syms beta

mos_R = Res == 1/(kn*beta*(vg-vs-vtn));
beta = double(solve(mos_R,beta));


%% Common source amplifier with source degeneration

vi = 0:0.1:1.8
kn = 330e-6;
mos_I= id == kn*1000*(vi-id*10e3-1).^2;

plot(id,vi);
