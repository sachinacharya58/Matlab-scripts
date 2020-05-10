
W = 4e-6;
N = 4;
L = 17.36e-9;
S = 0.5e-6;
const = 1.3e-7;

AF = @(x) const*x^(5/3) - L*( ((x/(4*N)) + W + (N-1)*(W+S))^(1/3)*(W^(0.083))*(W+S)^(0.25))

xi = 200;ed=0.01;
ltot = FixedPoint(AF,xi,ed);

% Fixed-Point Iteration Numerical Method for finding the x root of f(x) to make f(x) = 0
% by Roche de Guzman, Ph.D.
% Hofstra University
function [xR,err,n,xRV,errV,AFD1,AFD2] = FixedPointNM(AF,xi,ed)
% Inputs: with examples
% AF = anonymous function equation: AF = @(x) 1-((20^2)./(9.81*(((3*x)+((x.^2)/2)).^3))).*(3+x);
% xi = initial guess x = xR, where xR = x root: xi = 0.5;
% ed = desired approximate relative error = |(current - previous)/current|: ed = 0.01;
% Outputs
% xR = x root
% err = approximate relative error
% n = number of iterations
% xRV = x root vector
% errV = approximate relative error vector
% AFD1 = anonymous function 1st derivative
% AFD2 = anonymous function 2nd derivative
%% Computations
% Derivatives
AFSYM = sym(AF); % symbolic math function
AFD1SYM = diff(AFSYM); % symbolic math function 1st derivative
AFD2SYM = diff(AFD1SYM); % symbolic math function 2nd derivative
AFD1 = matlabFunction(AFD1SYM); % anonymous function 1st derivative
AFD2 = matlabFunction(AFD2SYM); % anonymous function 2nd derivative
% Fixed-Point Iteration Method
err = 1; % initial approximate relative error = 100%
k = 1; % initial counter
while ed < err % compares desired versus calculated error
    xR = xi+AF(xi); % x root using fixed point iteration method
    xRV(k+1) = xR; % stores the x root per iteration in a vector
    err = abs((xRV(k+1) - xRV(k))/xRV(k+1)); % approximate relative error
    errV(k+1) = err; % stores the error into a vector
    xi = xR; % new guess x = xR, where xR = x root
    k = k+1; % increase counter
end
n = k - 1; % number of iterations
xRV = xRV(2:end); % readjust x root vector
errV = errV(2:end); % readjust approximate relative error vector
end