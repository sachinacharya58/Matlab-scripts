clear;
clc;

%% parameters
gm1 = 200e-6;
gm2 = 100e-6;
gm3 = 10e-3;
go1 = 0.2e-6;
ro1 = 1/go1;
go2 = 50e-6;
ro2 = 1/go2;
C = 2e-12;
Cx = 1e-12;
Co2 = 1.5e-12;
Co1 = 0.5e-12;
R = 3000;

wRC = 1/(R*C);
fRC = wRC/(2*pi);
%% equations

Adc = (gm1*gm2*ro1*ro2) + (gm3*ro2);

wp1 = 1/(ro1*Co1);
fp1 = wp1/(2*pi);
tfp1 = tf(1,[(1/wp1) 1]);

wz1 = 0;
tfz1 = tf([1 wz1],1);

wz2 = (gm1*gm2 + gm3*go1)/(gm3*Co1);
fz2 = wz2/(2*pi);
tfz2 = tf([(1/wz2) 1],1);

w0 =  sqrt(1/((ro2*R)*(C*Cx+C*Co2+Cx*Co2)));
f0 = w0/(2*pi);
Q = sqrt(go2*R*(C*Cx + C*Co2 + Cx*Co2))/(go2*R*C + go2*R*Cx + C + Co2);
tfp23 = tf(w0^2,[1 (w0/Q) (w0^2)]);

wp2 = w0/(2*Q) - (w0/(2*Q))*sqrt(1-4*(Q^2));
fp2 = wp2/(2*pi);
wp3 = w0/(2*Q) + (w0/(2*Q))*sqrt(1-4*(Q^2));
fp3 = wp3/(2*pi);

LG = tfp1*tfz1*tfz2*tfp23*Adc*R*C;
w = logspace(-2,10,(1e6));
%%bode(LG,w)

beta = tf([R*C 0],[R*(C+Cx) 1]);
OLG = LG/beta;

CLG = feedback(OLG,beta);

bode(LG,w)
hold on
bode(OLG,w)
