clc;
close all;
clear all;

%% Miller effect

f = 10:1:10E6;
s = 2*pi*f;

C = 2E-12;

Z = 1./(s.*C);

plot(s,Z);