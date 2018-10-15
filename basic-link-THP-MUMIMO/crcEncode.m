function [crc_out] = crcEncode(crc_in,crc_mode)
%crcEncode - calculates a cyclic redundancy check (CRC) for the input data 
%vector and returns a copy of the vector with the CRC attached. 
% 
% Syntax:  [crc_out] = crcEncode(crc_in,crc_mode)
% 
% Input Arguments:
%    crc_in - Data bit vector 
%    crc_mode - CRC mode 
% 
% Output Arguments:
%    crc_out - Bit vector with CRC 

%----------------------------- BEGIN CODE --------------------------------- 
switch crc_mode
    case '24A'
        generator = [1,1,0,1,1,1,1,1,0,0,1,1,0,0,1,0,0,1,1,0,0,0,0,1,1];
        crc_size = 24;
    case '24B'
        generator = [1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1];
        crc_size = 24;
    case '16'
        generator = [1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0];
        crc_size = 16;
end
crc = zeros(1,24);
for j = 1:length(crc_in)
    temp = crc(1:23);
    crc(1) = mod((crc_in(j) + crc(crc_size)),2);
    crc(2:24) = mod(temp + crc(1)*generator(2:24),2);
end
crc_out = [crc_in,crc(crc_size:-1:1)];
end
%----------------------------- END OF CODE --------------------------------
