clc;
close all;
clear all;

Rcf = [];
for f = 10:1:200e3
    Rcf =  [Rcf,((12194^2).*(f.^2))/(((f.^2) + 20.6^2).*((f.^2) + 12194^2))];
end
f = 10:1:200e3;

A = [f; Rcf];
%fin = restyle_text(f);

fileID = fopen('weightfile.txt','w');
%fprintf(fileID,'%6s %12s\n','f','Rcf(f)');
fprintf(fileID,'%-6d %12.8f\n',A);
fclose(fileID);

