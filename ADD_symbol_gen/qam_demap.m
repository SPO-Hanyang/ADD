function y = qam_demap(b,modul)
% QAM symbol mapper
% b: Sequence of QAM symbols to be demodulated (1*N)
% modul: modulation order; 1:BPSK, 2:QPSK, 4:16QAM, 6:64QAM
% y: Sequence of original bits that has been modulated (modul*N)
% N: Number of input sequence

x = b;
L = size(b,2);
y = zeros(modul,L);

for k = 1 : L
    if modul == 1
        y(1,k) = x(1,k) > 0;
    elseif modul == 2
        y(1,k) = real(x(1,k))>0;
        y(2,k) = imag(x(1,k))>0;
    elseif modul == 4
        % DEMAP 16-QAM signal
        % -3 --> 00, -1 --> 01, 1 --> 11,  3 --> 10
        y(1,k) = sign(real(x(1,k)))>0;
        y(2,k) = (2-abs(real(x(1,k))*sqrt(10)))>0;
        y(3,k) = sign(imag(x(1,k)))>0;
        y(4,k) = (2-abs(imag(x(1,k))*sqrt(10)))>0;
    elseif modul == 6
        % DEMAP 64-QAM signal
        % -7 --> 000, -5 --> 001, -3 --> 011,  -1 --> 010, 1 --> 110, 3 --> 111
        % 5 --> 101, 7 --> 100
        y(1,k) = sign(real(x(1,k)))>0;
        temp = round(abs(real(x(1,k))*sqrt(42)));
%         if temp <= 2
%             temp = 1;
%         elseif temp < 4 && temp > 2
%             temp = 3;
%         elseif temp < 6 && temp > 4
%             temp = 5;
%         else
%             temp = 7;
%         end
        
        if temp == 7
            y(2,k) = 0;
            y(3,k) = 0;
        elseif temp == 5
            y(2,k) = 0;
            y(3,k) = 1;
        elseif temp == 3
            y(2,k) = 1;
            y(3,k) = 1;
        else
            y(2,k) = 1;
            y(3,k) = 0;
        end

        y(4,k) = sign(imag(x(1,k)))>0;
        temp = round(abs(imag(x(1,k))*sqrt(42)));
%         if temp <= 2
%             temp = 1;
%         elseif temp < 4 && temp > 2
%             temp = 3;
%         elseif temp < 6 && temp > 4
%             temp = 5;
%         else
%             temp = 7;
%         end
        
        if temp == 7
            y(5,k) = 0;
            y(6,k) = 0;
        elseif temp == 5
            y(5,k) = 0;
            y(6,k) = 1;
        elseif temp == 3
            y(5,k) = 1;
            y(6,k) = 1;
        else
            y(5,k) = 1;
            y(6,k) = 0;
        end
    end
end