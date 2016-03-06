function [src_data, y_trans, y_received, sym_hat, src_hat, BER ] = sym_generator( T_bit, OvR, T_samp, alpha, SNR_dB, numbit, modul, Nsym, numsym, num_iter )

BER = zeros(size(SNR_dB)) ;

for q = 1:num_iter
    %% Source bit generation
    src_data = (rand(numbit,1)-0.5)>0;
    
    %% Mapping
    src_vec = reshape(src_data, [modul, numbit/modul]);
    mod_data = qam_map(src_vec,modul).';
    
    %% Oversampling
    mod_data_oversampled = zeros(size(mod_data,1)*OvR,1);
    mod_data_oversampled(1:OvR:end) = mod_data;
    
    rcos_filt=rcosdesign(alpha,Nsym,OvR,'sqrt');        % Raised cosine filter
    
    y_trans = upfirdn(mod_data,rcos_filt, OvR);               % Pulse shaping
    
    for i = 1:length(SNR_dB)
        
        y_received = y_trans + randn(size(y_trans))/(10^(SNR_dB(i)/20))/sqrt(2) + sqrt(-1) * randn(size(y_trans))/(10^(SNR_dB(i)/20))/sqrt(2);        % Adding noise
        
        y_received = upfirdn(y_received,rcos_filt, 1);
        y_received = y_received(Nsym*OvR+1:1:end);
        y_downsamp = y_received(1:OvR:OvR*numsym);
        
        if modul >= 4
            [sym_hat, idx] = slicer(y_downsamp, modul);
        else
            sym_hat = y_downsamp;
        end
        
        b_vec = qam_demap(sym_hat.',modul);
        src_hat = reshape(b_vec, [numbit,1]);
        BER(i) = BER(i) + sum(abs(src_data-src_hat))/numbit;
    end
end

BER = BER / num_iter;

end