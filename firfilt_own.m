function [outputArg1] = firfilt_own(inputArg1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    H = [1/3,1/3,1/3];
    outputArg1 = conv(H,inputArg1);
end

