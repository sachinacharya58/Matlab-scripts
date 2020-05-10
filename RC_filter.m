clc;
close all;
clear all;

%% RC filter implementation
t = 0:1:100;
% x = sin(2*pi*10*t)
x = (t>1)*1 + (t~=1)*0; 
R = 1E6; C = 10E-12;
y = [];

a = 1/(1+(R*C));
b = R*C/(1+(R*C));

% From Euler expansion
for i = 1:length(x)
    if i == 1
        y = a*x(i);
    else
        y = [y, a*x(i) + b*y(i-1)]
    end
end

figure(1)
plot(t,y);
%% Laplace domain
sys = tf(1,[R*C 1])
figure(2)
lsim(sys,x,t);
