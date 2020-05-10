clc;
close all;
clear all;

%%%%%%%%%%%%% %%%%%%%%%%%%%%%%
row1_1 = ["Parameter/Block"]; row1_2 = ["BSF" "LNA" "Mixer" "Filter" "VGA"];
row1 = [row1_1 row1_2];
row2_1= ["NF [dB]"];row2_2 = [2 3 10 15 15];
row2 = [row2_1 row2_2];
row3 = ["Gain [dB]"  -2 12 9.5 30 47];
row4 = ["IIP3 [dBm]" 0  -2  -8 -7 6];
spec_table = [row1;row2;row3;row4];
Psen = -85; T = 300; k = physconst('Boltzmann'); BW = 2E6;
Int_noise = 10*log10(k*T*BW/(1e-3));
Signal_level = [Psen];
Noise_level = [Int_noise];

%%%%%%%%%%%%%%%%%%% QUESTION 3 %%%%%%%%%%%%%%%%%%%%%%%%
NF = 1; %(spec_table(2,i)
tot_gain = 0; IIIP3 = 0;
for i = 2:6
    temp1 = ((10.^(str2num(spec_table(2,i))/10.0))-1);
    temp2 = (10^(tot_gain/10.0));
    NF = NF + temp1/temp2;
    IIIP3 = IIIP3 + 1/(10.^((str2num(spec_table(4,i))-tot_gain)/10.0));
    tot_gain = tot_gain + str2num(spec_table(3,i));
    Signal_level = [Signal_level,Signal_level(1)+tot_gain];
    noisedb = 10*log10(NF);
    lvl_noise = noisedb + Int_noise + tot_gain;
    Noise_level = [Noise_level,lvl_noise];
end
  
SNR = Signal_level-Noise_level;

System_NF2 = 10*log10(NF)
System_IIP3_2 = 10*log10(1/IIIP3)

plot (Signal_level,'-o');
set(gca,'xticklabel',row1_2')
hold on;plot (Noise_level,'-s');
%hold on;plot (Noise_level2,'-s');
set(gca,'xtick',1:6,'XTickLabel',[row1_2,"Demod"])
legend('signal level','noise level (actual','noise level (theory)');
ylabel('Input signals and noise levels (dBm)');grid on

figure
plot (SNR,'-o');
set(gca,'xtick',1:6,'XTickLabel',[row1_2,"Demod"])
ylabel('Input level SNR (dBm)');grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


