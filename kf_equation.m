clc;
close all;
clear all;

%%

y_inter = -10.43;

syms KF
unCox = 40e-6;
W = 1000e-9; L = 500e-9;
tox = 3.74e-9; e0 = 8.854e-12;
Cox = 3.9*e0/tox;

eqn1 = 10^y_inter == KF/(2*unCox*W*L*Cox);

KF = double(solve(eqn1,KF));


%% Input integrated flicker noise

clc;
close all;
clear all;

unCox = 100e-6;
W = 1000e-9; L = 700e-9;
tox = 3.74e-9; e0 = 8.854e-12;
Cox = 3.9*e0/tox;
KF = 5.028e-28;
V_sq = 30e-6;

syms Area
mos_flicker = V_sq == sqrt((2*KF/(2*unCox*Area*Cox))*(log(200e6)-log(10)));
Area = double(solve(mos_flicker,Area));