function y = qam_map(b,modul)
% QAM symbol mapper
% b: Sequence of input bits to be modulated into QAM (modul*N)
% modul: Modulation order; 1:BPSK, 2:QPSK, 4:16QAM, 6:64QAM
% y: Sequence of modulated symbols (1*N)
% N: Number of input sequence



x = b;

if  size(x,1) ~= modul
    fprintf('Constellation size mismatch');
end

y = zeros(1,size(x,2));

if modul == 1
    for i = 1 : size(x,2)
        y(i) = 2*x(i) - 1;
    end
elseif modul == 2
    % MAP QPSK signal
    % 00 -> -1-j, 01 -> -1+j, 10 -> 1-j, 11 -> 1+j
    x = 2*x-1;
    for i = 1 : size(x,2)
        y(i) = 1/sqrt(2)*(x(1,i)+sqrt(-1)*x(2,i));
    end
elseif modul == 4
    % MAP 16-QAM signal
    % 00 -> -3, 01 -> -1, 11 -> 1, 10 -> 3
    x =2*x-1;
    for i = 1 : size(x,2)
        y(i) = sign(x(1,i))*(2-x(2,i))/sqrt(10) + sqrt(-1)*sign(x(3,i))*(2-x(4,i))/sqrt(10);
    end
elseif modul == 6
    % MAP 64-QAM signal
    % -7 --> 000, -5 --> 001, -3 --> 011,  -1 --> 010, 1 --> 110, 3 --> 111
    % 5 --> 101, 7 --> 100
    x = 2*x-1;
    for i = 1 : size(x,2)
        if x(2,i) == -1 && x(3,i) == -1
            temp1 = 7;
        elseif x(2,i) == -1 && x(3,i) == 1
            temp1 = 5;
        elseif x(2,i) == 1 && x(3,i) == 1
            temp1 = 3;
        else
            temp1 = 1;
        end
        if x(5,i) == -1 && x(6,i) == -1
            temp2 = 7;
        elseif x(5,i) == -1 && x(6,i) == 1
            temp2 = 5;
        elseif x(5,i) == 1 && x(6,i) == 1
            temp2 = 3;
        else
            temp2 = 1;
        end

        y(i) = sign(x(1,i))*temp1/sqrt(42) + sqrt(-1)*sign(x(4,i))*temp2/sqrt(42);
    end
end
