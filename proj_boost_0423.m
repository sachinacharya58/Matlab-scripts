clear; clc;

%% parameters
L = 21e-6;
Rl = 2.7;
fsw = 1e6;
C = 1000e-9;
%Rload = 1.36e3;
Isw_lim = 500e-3;

Vg = 3.6;
Vout = 10;
Iled = 20e-3;
Rs = 13;

Doff = Vg/Vout;
Don = 1 - Doff;
Leq = L/((Doff)^2);
%Vo = Vg/Doff;
Rload = Vout/Iled;
Rled = Rload-Rs;

Rc = 10e-3;
%% CCM
kc = (2*L*fsw)/Rload;
CCM_check = kc - (Don*(Doff^2));

% syms D
% Db = 1 - D;
% eqn1 = D > 0;
% eqn2 = D <= 1;
% eqn3 = D*(Db^2) > kc;
% eqns = [eqn1 eqn2 eqn3];
% 
% S = solve(eqns,D,'ReturnConditions',true);
% S.D

%% ripple calculation

Vripple = (Iled/C)*((1/fsw)-((Isw_lim + ((Vg/L)*100e-9))*L)/(Vout+0.3-Vg));

%% setting poles and zeros

%% main loop
wz_esr = 1/(Rc*C);
fz_esr = wz_esr/(2*pi);
tfz_esr = tf([(1/wz_esr) 1], 1);

wz_rhp = ((Doff^2)*Rload - Rl)/L;
fz_rhp = wz_rhp/(2*pi);
tfz_rhp = tf([(-1/wz_rhp) 1], 1);

wlc =  (sqrt(1/(L*C)))*(sqrt((Rl+((Doff^2)*Rload))/Rload));
flc = wlc/(2*pi);
Q = wlc/((Rl/L)+(1/(C*(Rload+Rc))));
tfp_lc = tf(1,[(1/(wlc^2)) (1/(wlc*Q)) 1]);


%% compensator
R1 = Rled;
R4 = R1 * 100;

fp2 = 250;
fz2 = 25e3;
fz1 = 42e3;
fp1 = 1000e3;

R2 = R4/((fz2/fp2)-1);
R3 = R1/((fp1/fz1)-1);

wp1 = fp1*(2*pi);
tfp1 = tf(1,[(1/wp1) 1]);


wp2 = fp2*(2*pi);
tfp2 = tf(1,[(1/wp2) 1]);


wz1 = fz1*(2*pi);
tfz1 = tf([(1/wz1) 1],1);
%tfz1 = 1;

wz2 = fz2*(2*pi);
tfz2 = tf([(1/wz2) 1],1);
%tfz2 = 1;

C1 = 1/(R2*wz2);
C2 = 1/(R3*wp1);

Av = Vg/(Doff^2);
Aop = R4/R1;

tf = tfp1*tfp2*tfp_lc*tfz1*tfz2*tfz_esr*tfz_rhp*Av*Aop;


w = logspace(0,8,(1e6));

tf_comp = tfp1*tfp2*tfz1*tfz2*Aop;

%subplot(2,1,1)
%margin(tf_comp)
%subplot(2,1,2)
%figure()
[GM,PM,Wcg,Wcp] = margin(tf);
Wcp/(2*pi)
PM
margin(tf)
%margin(Av*tfp_lc)