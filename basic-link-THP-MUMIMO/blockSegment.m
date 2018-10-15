function [crc_cell,rate_recover_size,turbo_block_num] = blockSegment(crc)
%blockSegment - code block segment
%
% Syntax:  [crc_cell,rate_recover_size,turbo_block_num] = blockSegment(crc)
%
% Input Arguments:
%    crc - crc data
%
% Output Arguments:
%    crc_cell - crc data
%    rate_recover_size - rate recover size
%    turbo_block_num - turbo block num

%----------------------------- BEGIN CODE ---------------------------------
if length(crc) > 6144
    turbo_block_num = ceil(length(crc)/6120);
else
    turbo_block_num = 1;
end
crc_cell = cell(turbo_block_num,1);
rate_recover_size = cell(turbo_block_num,1);
if turbo_block_num > 1
    for i = 1:turbo_block_num
        if length(crc) > 6120
            crc_cell{i} = crc(1:6120);
            rate_recover_size{i} = 6120;
            crc(1:6120) = [];
        else
            crc_cell{i} = crc;
            rate_recover_size{i} = length(crc);
        end
    end
else
    crc_cell{1} = crc;
    rate_recover_size{1} = length(crc)-24;
end
end
%----------------------------- END OF CODE --------------------------------
