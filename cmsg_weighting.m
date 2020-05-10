clc;
close all;
clear all;

%
syms Rin f
k = 1.38e-23; T = 300;

Rcf = ((12194^2)*(f^2))/(((f^2) + 20.6^2)*((f^2) + 12194^2));
%cmsg_tot = double(int(Rcf,[20 20e3]));
viip = 2e-6;
%cmsg = (viip)^2 == int(4*k*T*Rin*(1.025), [20 20e3]); %*(Rcf)
flatmsg = (viip)^2 <= (4*k*T*Rin*(1.025)*(3300-300)); %*(Rcf)
%sqrt(int(Rcf*Rin*4*k*T(1+(1/40))),[20 20e3]);
Rin = double(solve(flatmsg,Rin));