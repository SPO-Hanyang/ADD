clear all;
close all;
clc;

T_bit  = 100*10^-6;     % bit interval : 100us
T_samp = T_bit/OvR;     % sampling interval

modul  = 1;             % Modulation order
numsym = 10000;         % Number of symbols
numbit = modul*numsym;  % Number of bits

alpha  = 0.5;           % Roll-off factor
Nsym_filt = 8;                 
OvR    = 10;            % Oversampling rate

num_iter = 10;

SNR_dB = 1 : 21;        % SNR(dB)
SNR = 10.^(SNR_dB/10);
EbN0_dB = SNR_dB - 10*log10(modul);


[src_data, y_trans, y_received, sym_hat, src_hat, BER] = sym_generator(T_bit,OvR,T_samp,alpha,SNR_dB,numbit,modul,Nsym_filt,numsym,num_iter);


if modul == 1
    BER_theory = qfunc(sqrt(2*SNR));    
elseif modul == 2    
    BER_theory = berawgn(EbN0_dB, 'psk', 4,'nondiff');
elseif modul == 4    
    BER_theory = berawgn(EbN0_dB, 'qam', 16);
elseif modul == 6   
    BER_theory = berawgn(EbN0_dB, 'qam', 64);
end



figure;
semilogy(SNR_dB,BER_theory);
hold on; grid on
scatter(SNR_dB, BER, 'o');
xlabel('E_b/N_o [d B]'); ylabel('P_E_,_b_i_t')
title(['Bit Error Rate [ Mod.order : ',num2str(2^modul), ' ]']);


