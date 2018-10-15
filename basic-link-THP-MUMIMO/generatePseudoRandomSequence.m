function [c] = generatePseudoRandomSequence(c_init,sequence_size)
%generatePseudoRandomSequence - generate pseudo-random sequence.
%details on 3GPP TS 36.211 7.2
% 
% Syntax:  [c] = generatePseudoRandomSequence(c_init,sequence_size)
% 
% Input Arguments:
%    c_init - initial value 
%    sequence_size - length of sequence  
% 
% Output Arguments:
%    c - pseudo-random sequence 

%----------------------------- BEGIN CODE --------------------------------- 
Nc = 1600;

x1 = zeros(1,sequence_size+Nc);
x1(1) = 1;
x1(2:31) = 1;
for k = 32:sequence_size+Nc
    x1(k) = mod(x1(k-28) + x1(k-31), 2);
end

x2 = zeros(1,sequence_size+Nc);
cinit_b = dec2bin(c_init,31);
x2(1:31) = cinit_b(31:-1:1) - '0';
for k = 32:sequence_size+Nc
    x2(k) = mod(x2(k-28) + x2(k-29) + x2(k-30) + x2(k-31), 2);
end

c = mod(x1(1+Nc:sequence_size+Nc) + x2(1+Nc:sequence_size+Nc), 2);
end
%----------------------------- END OF CODE --------------------------------
