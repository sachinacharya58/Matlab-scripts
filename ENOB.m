clc;
close all;
clear all;

%%
settling = 2.0141102 ;
delta = settling - 2.0;
LSB = 1/(2^12);

N_LSB = abs(delta)/LSB;
syms N
find_N = abs(delta) == 1/(2^N);

N = double(solve(find_N,N));