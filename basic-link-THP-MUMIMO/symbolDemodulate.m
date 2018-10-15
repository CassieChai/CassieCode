function [out] = symbolDemodulate(in,order)
%symbolDemodulate - Demodulation and symbol to bit conversion
%
% Syntax:  [out] = symbolDemodulate(in,order)
%
% Input Arguments:
%    in - Input symbols to demodulate
%    order - Modulation format.QPSK(2)£¬16QAM(4), 64QAM(6)
%
% Output Arguments:
%    out - Demodulated output bits

%----------------------------- BEGIN CODE ---------------------------------
len = length(in);
input_i = real(in);
input_q = imag(in);
mode = order/2;
switch mode
    case 1
        out(1:2:len*2) = -input_i*sqrt(2);
        out(2:2:len*2) = -input_q*sqrt(2);
    case 2
        bit = 4;%number of bit per symbol
        const1 = sqrt(10);
        input_i = input_i*const1;
        input_q = input_q*const1;
        %first bit
        idx1 = find(input_i>2);
        out(idx1*bit-3) = 2-2*input_i(idx1);
        idx2 = find(input_i<-2);
        out(idx2*bit-3) = -2-2*input_i(idx2);
        idx3 = setdiff(setdiff(1:len,idx1),idx2);
        out(idx3*bit-3) = -input_i(idx3);
        %second bit
        idx1 = find(input_q>2);
        out(idx1*bit-2) = 2-2*input_q(idx1);
        idx2 = find(input_q<-2);
        out(idx2*bit-2) = -2-2*input_q(idx2);
        idx3 = setdiff(setdiff(1:len,idx1),idx2);
        out(idx3*bit-2) = -input_q(idx3);
        %third and forth bit
        out(3:bit:len*bit) = abs(input_i)-2;
        out(4:bit:len*bit) = abs(input_q)-2;
    case 3
        bit = 6;
        const1 = sqrt(42);
        input_i = input_i*const1;
        input_q = input_q*const1;
        %first bit
        idx1 = find(input_i>6);
        out(idx1*bit-5) = 12-4*input_i(idx1);
        idx2 = find(input_i<-6);
        out(idx2*bit-5) = -12-4*input_i(idx2);
        idx3 = find(and(input_i<=6,input_i>4));
        out(idx3*bit-5) = 6-3*input_i(idx3);
        idx4 = find(and(input_i<=4,input_i>2));
        out(idx4*bit-5) = 2-2*input_i(idx4);
        idx5 = find(and(input_i>=-6,input_i<-4));
        out(idx5*bit-5) = -6-3*input_i(idx5);
        idx6 = find(and(input_i>=-4,input_i<-2));
        out(idx6*bit-5) = -2-2*input_i(idx6);
        idx7 = find(abs(input_i)<=2);
        out(idx7*bit-5) = -input_i(idx7);
        %second bit
        idx1 = find(input_q>6);
        out(idx1*bit-4) = 12-4*input_q(idx1);
        idx2 = find(input_q<-6);
        out(idx2*bit-4) = -12-4*input_q(idx2);
        idx3 = find(and(input_q<=6,input_q>4));
        out(idx3*bit-4) = 6-3*input_q(idx3);
        idx4 = find(and(input_q<=4,input_q>2));
        out(idx4*bit-4) = 2-2*input_q(idx4);
        idx5 = find(and(input_q>=-6,input_q<-4));
        out(idx5*bit-4) = -6-3*input_q(idx5);
        idx6 = find(and(input_q>=-4,input_q<-2));
        out(idx6*bit-4) = -2-2*input_q(idx6);
        idx7 = find(abs(input_q)<=2);
        out(idx7*bit-4) = -input_q(idx7);
        %third bit
        idx1 = find(abs(input_i)>6);
        out(idx1*bit-3) = 2*abs(input_i(idx1))-10;
        idx2 = find(abs(input_i)<=2);
        out(idx2*bit-3) = 2*abs(input_i(idx2))-6;
        idx3 = setdiff(setdiff(1:len,idx1),idx2);
        out(idx3*bit-3) = abs(input_i(idx3))-4;
        %forth bit
        idx1 = find(abs(input_q)>6);
        out(idx1*bit-2) = 2*abs(input_q(idx1))-10;
        idx2 = find(abs(input_q)<=2);
        out(idx2*bit-2) = 2*abs(input_q(idx2))-6;
        idx3 = setdiff(setdiff(1:len,idx1),idx2);
        out(idx3*bit-2) = abs(input_q(idx3))-4;
        %fifth bit
        idx1 = find(abs(input_i)>4);
        out(idx1*bit-1) = abs(input_i(idx1))-6;
        idx2 = setdiff(1:len,idx1);
        out(idx2*bit-1) = -abs(input_i(idx2))+2;
        %sixth bit
        idx1 = find(abs(input_q)>4);
        out(idx1*bit) = abs(input_q(idx1))-6;
        idx2 = setdiff(1:len,idx1);
        out(idx2*bit) = -abs(input_q(idx2))+2;
end
end
%----------------------------- END OF CODE --------------------------------