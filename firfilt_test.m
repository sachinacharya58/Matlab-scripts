clc;
close all;
clear all;

%% Z-transform

X = rand(5,1);
Y_own = firfilt_own(X);
H = [1/3,1/3,1/3];
Y_filter = filter(H,1,X);