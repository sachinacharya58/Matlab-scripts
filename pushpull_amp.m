clc;
close all;
clear all;

%% SLEW RATE

SR = 4.1e6;
CL = 40e-12;
Cc = 1e-12;

syms ID
SR_eqn1 = SR == ID/(CL+Cc);
ID = double(solve(SR_eqn1,ID));

syms IB
SR_eqn2 = SR == IB/Cc;
IB = double(solve(SR_eqn2,IB));

%% Current budget
PC = 1e-3;
I_budget = PC/5;

I_left = I_budget - (ID + 4*IB)

%% Output pole
% 
% syms lambda
% GBW = 2*pi*5e6;
% 
% %Ro = R == 1/(lambda*ID);
% non_dom_pole = lambda*ID/(2*CL) == 2*GBW;
% 
% lambda = double(solve(non_dom_pole,lambda));

%% Biasing circuits
kn = 100e-6;
kp = 40e-6;
Vtn = 0.65;

% % Output stage
% id = 80e-6;
% Vovp = 0.15;
% Vovn = 0.15;
% %syms Vovp;1.66
% syms betan;
% syms betap;
% mos_N = id == kn* betan * Vovn^2 / 2;
% mos_P = id == kp* betap * Vovp^2 / 2;
% 
% betan = double(solve(mos_N,betan));
% betap = double(solve(mos_P,betap));
% 

% Biasing stage
id = 1e-6;
Vtn = 0.6115;
Vovn = 764.4e-3 - Vtn ;
Vovp = 5 - 4.258 - Vtn ;
%syms Vovp;
syms betan;
syms betap;
mos_N = id == kn* betan * Vovn^2 / 2;
mos_P = id == kp* betap * Vovp^2 / 2;

betan = double(solve(mos_N,betan));
betap = double(solve(mos_P,betap));

Vb = 2*Vovp + Vtn;


%% GBW and gm
GBW = 2*pi*5.5e6;

gm = GBW*Cc;
Vov_in = 2*IB/gm; % Overdrive for the input transistor

syms betan_in betap_in
gmn_eqn1 = gm == kn*betan_in*Vov_in;
gmp_eqn2 = gm == kp*betap_in*Vov_in;

betan_in = double(solve(gmn_eqn1,betan_in));
betap_in = double(solve(gmp_eqn2,betap_in));
