clc;
close all;
clear all;

%% GBW
GBW = 2*pi*11e6; 
non_dom = 2.5*GBW; w_rhpzero = 4*GBW;
Cl = 15e-12;
gm2p = non_dom*Cl; Cc = gm2p/(w_rhpzero);
gm1 = Cc*GBW;
PM = 90 - (180/pi)*( atan(GBW/non_dom) + atan(GBW/w_rhpzero)); % 
% Aiming for a gain of 40 dB in the first stage
Avn1 = 52.672; gmIdn = 20.539 ; Vgs = 400e-3;
Id = gm1/gmIdn; SR1 = 2*Id/Cc; 
Id_WN = 28.91; W1 = Id/Id_WN; L = 540e-9;

% Vcm = 0.1; Vds1 > Vgs-Vth > 300mV = 330mV;
Vov_2 = 1.1 - 0.1 - 0.330 - 0.33;

Avp2 = 190.834; gmIdp = 20; gm2 = gmIdp*Id; Vgsp = 417e-3;
ID_WP = 10.01; W2 = Id/ID_WP;

A_1stg = 1/((1/Avn1) + (gm2/gm1)*(1/Avp2));
A1_dB = 20*log10(A_1stg);

%% A_cm = 40; gmIdn = 15.59; 2*Id = 75.714uA
gmIdn = 15.59; Vgsn = 520.99e-3;Id_WN = 52.03; Wcm = 2*Id/Id_WN;


%% 2nd stage
VgsP = 480.7e-3; gmidp = 17.36; Avp = 163.288;
gm2 = 2.6e-3; Id2 = gm2/17.36;
Id_WP = 13.79; WP3 = Id2/Id_WP;
    
Vgsn2 = 521e-3; Gm_IDN = 15.631; Avn2 = 40.01;
gmn2 = Gm_IDN*Id2; Id_WN = 51.84; WN3 = Id2/Id_WN;
A_2stg = 1/((1/Avp) + ((1/Avn2)*(gmn2/gm2)));
A2_dB = 20*log10(A_2stg);

%% 
Vgsn2 = 541e-3; Gm_IDN = 15.631; Avn2 = 40.01; Ibias = 5e-6;
gmn2 = Gm_IDN*Ibias; Id_WN_bias = 51.84; WN_bias = Ibias/Id_WN;
