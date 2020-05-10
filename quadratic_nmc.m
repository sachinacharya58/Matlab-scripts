syms var
Cm1 = 1.6e-12;
Cm2 = 0.4e-12;
gm2 = 574e-6;
gmL = 10.5e-3;
eqn = 0 == 1-(var*Cm2/gmL)-var^2*(Cm1*Cm2/(gm2*gmL));

S = double(solve(eqn,var))

%% 
syms Av1 Av2 Av3 wp1 wp2
syms s
DC_gain = (Av1*Av2 + Av3);
wz = (wp1*DC_gain)/Av3;
FF = -(DC_gain*(1+s/wz))/((1+s/wp1)*(1+s/wp2));

syms R C Cx
beta = s*C*R/(1+s*R*(Cx+C));
LG = FF/(1-beta*FF);
pretty(LG)
%G = tf(1,[2 k]);

%%
syms Av1 Av2 Av3 wp1 wp2 R C Cx s
R = 1e3; C = 2e-12; Cx = 1e-12;
DC_gain = (Av1*Av2 + Av3);
wz = (wp1*DC_gain)/Av3;

eqn = DC_gain*(1+s/wz);
eqn1 = 1+((s*C*R)*(eqn)/((1+s/wp1)*(1+s/wp2)*(1+s*R*(Cx + C))));
den = eqn1 == 0;
assume (wp1~=0 & wp2 ~=0 & wz ~=0 & Av1 > 0 & Av2 > 0 & Av3 > 0);


roots = (solve(den,s))
pretty(roots(2))

%% 
clc; close all; clear all;
syms s go2 
Co2 = 1e-12;
R = 3e3; C = 2e-12; Cx = 1e-12;

eqn = 0 == 1 + s*( (R*(Cx + C)) + (C/go2) + (Co2/go2) ) + s^2*((R*C*Cx/go2) + (Co2*R*(Cx+C)/go2));
poles = (solve(eqn,s));

pretty(poles(2))
