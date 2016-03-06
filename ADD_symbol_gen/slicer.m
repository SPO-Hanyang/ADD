function [y,idx] = slicer(x,n)
% Slicer
% x: input
% n: Modulation order
% y: output (closest constellation point from x)
% Initial check-in by Jun, Oct. 2008

L = length(x);
y = zeros(size(x));

if n == 1
    for i = 1 : L
        y(i) = 2*(real(x(i)) > 0)-1;
    end
    
elseif n == 2
    % 4-QAM
    for i = 1 : L
        idx1 = 1;
        idx2 = 1;
        
        idx(i) = (idx1-1)*sqrt(2^n)+idx2;
    end

elseif n == 4
    % 16-QAM
    for i = 1 : L
        x2 = x(i)*sqrt(10);
        if real(x2) < -2
            temp1 = -3/sqrt(10);
            idx1 = 1;
        elseif real(x2) <0
            temp1 = -1/sqrt(10);
            idx1 = 2;
        elseif real(x2) <2
            temp1 = 1/sqrt(10);
            idx1 = 3;
        else
            temp1 = 3/sqrt(10);
            idx1 = 4;
        end

        if imag(x2) < -2
            temp2 = -3/sqrt(10);
            idx2 = 1;
        elseif imag(x2) <0
            temp2 = -1/sqrt(10);
            idx2 = 2;
        elseif imag(x2) <2
            temp2 = 1/sqrt(10);
            idx2 = 3;
        else
            temp2 = 3/sqrt(10);
            idx2 = 4;
        end
        y(i) = temp1 + sqrt(-1)*temp2;
        idx(i) = (idx1-1)*sqrt(2^n)+idx2;
    end
   
elseif n == 6
    % 64-QAM
    for i = 1 : L
        x2 = x(i)*sqrt(42);
        if real(x2) < -6
            temp1 = -7/sqrt(42);
            idx1 = 1;
        elseif real(x2) < -4
            temp1 = -5/sqrt(42);
            idx1 = 2;
        elseif real(x2) < -2
            temp1 = -3/sqrt(42);
            idx1 = 3;
        elseif real(x2) < 0
            temp1 = -1/sqrt(42);
            idx1 = 4;
        elseif real(x2) < 2
            temp1 = 1/sqrt(42);
            idx1 = 5;
        elseif real(x2) < 4
            temp1 = 3/sqrt(42);
            idx1 = 6;
        elseif real(x2) < 6
            temp1 = 5/sqrt(42);
            idx1 = 7;
        else
            temp1 = 7/sqrt(42);
            idx1 = 8;
        end

        if imag(x2) < -6
            temp2 = -7/sqrt(42);
            idx2 = 1;
        elseif imag(x2) < -4
            temp2 = -5/sqrt(42);
            idx2 = 2;
        elseif imag(x2) < -2
            temp2 = -3/sqrt(42);
            idx2 = 3;
        elseif imag(x2) < 0
            temp2 = -1/sqrt(42);
            idx2 = 4;
        elseif imag(x2) < 2
            temp2 = 1/sqrt(42);
            idx2 = 5;
        elseif imag(x2) < 4
            temp2 = 3/sqrt(42);
            idx2 = 6;
        elseif imag(x2) < 6
            temp2 = 5/sqrt(42);
            idx2 = 7;
        else
            temp2 = 7/sqrt(42);
            idx2 = 8;
        end

        y(i) = temp1 + sqrt(-1)*temp2;
        idx(i) = (idx1-1)*sqrt(2^n)+idx2;
    end
    
end
    
    
        
    

