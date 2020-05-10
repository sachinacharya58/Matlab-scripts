clc;
close all;
clear all;

M = dlmread('\\blender\homes\s\a\sachinacharya58\nt\s_parameters.txt','',3,0);
Freq = [M(:,1)]; R_S11 = [M(:,2)]; PHI_S11 = [M(:,3)];
X_S11 = R_S11.*cos(PHI_S11);
Y_S11 = R_S11.*sin(PHI_S11);
RECT_S11 = complex(X_S11,Y_S11);
MAG_S11 = abs(RECT_S11);

%plot(Freq, MAG_S11);
D=[];
%D = {'* ampdata.amp: the data of a 1.9GHz amplifier in .AMP format '};
D = {M(1:end,:)};

freq = [];
for j=1:1:length(M)
	sp_vec(:,:,j) = ...
    [M(j,2)*cos(M(j,3))+ M(j,2)*sin(M(j,3))*i, M(j,4)*cos(M(j,5))+ M(j,4)*sin(M(j,5))*i; ...
      M(j,6)*cos(M(j,7))+ M(j,6)*sin(M(j,7))*i, M(j,8)*cos(M(j,9))+ M(j,8)*sin(M(j,9))*i];
    freq = [freq M(j,1)];
end

txdata = rfdata.data;
txdata.S_parameters = sp_vec;
txdata.Freq = freq;
write(txdata,'genamp.amp')
