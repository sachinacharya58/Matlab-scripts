clc;
close all;
clear all;

%% Negative loop mag must be greater than positve loop
Ib = 40e-6; k = 1.38e-23; T=300-70; q = 1.6e-19;
Vt = k*T/q; n = 8;

gq2 = Ib/Vt;
gq1 = Ib/(n*Vt);

syms R1 R2
eqn1 = R1 > 0;
eqn2 = R2 > 0;
eqn3 = gq2*(1+(gq1*(R1 + ((R2/(1+(gq2*R2))))))) < gq1*(1+(gq2*R2*((1+(gq1*R1))/(1+(gq1*(R1+R2))))));
eqns = [eqn1 eqn2 eqn3];

R = solve(eqns,[R1 R2]);
R.R2

%%
R1 = 2e3; R2 = 45.85343e3;
num1 = gq2*(1+(gq1*(R1 + ((R2/(1+(gq2*R2)))))));
den  = gq1*(1+(gq2*R2*((1+(gq1*R1))/(1+(gq1*(R1+R2))))));

%% dVbe2/dT = -1.54m, dVt/dT = 0.086m, 
Ib = 40e-6; k = 1.38e-23; T=300-70; q = 1.6e-19;
Vt = k*T/q; n = 8;
K = 20.3488; n = 8;
R_ratio = K/(2*log(8));
K*Vt
Vbg = 1.32; Vbe2 = 781.252e-3; Id1 = 60e-6;

R2 = (Vbg - Vbe2)/(2*Id1);
R1 = R2/R_ratio;

%% Loop gains
Ib = 40e-6; k = 1.38e-23; T=300-70; q = 1.6e-19;
Vt = k*T/q; n = 8;

gq2 = Ib/Vt;
gq1 = Ib/(n*Vt);

K = 1.75/0.086; n = 8;
R_ratio = K/(2*log(n));

Vbg = 1.35; Vbe2 = 781.252e-3; Id1 = 40e-6;
Vbe1 = 726e-3;
R2 = (Vbg - Vbe2)/(2*Id1);
R1 = (Vbg - Vbe1 -2*Id1*R2)/Id1;
R1_k = R2/R_ratio;

gm1 = 71.03e-6; gm2 = 71.03e-6;gm3 = 67.85e-6; Rl = 31e3;
lda = 0.01; ro = 1/(lda*Ib);

P_LG = gm3*Rl*gq2*ro/(1+(gq2*r_parallel(R2,R1+(1/gq1))));
N_LG = gm3*Rl*(gq1/gm1)*gm2*ro/(1+(gq1*(R1 + r_parallel(R2,1/gq2))));