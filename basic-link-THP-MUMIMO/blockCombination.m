function [message] = blockCombination(message_cell,turbo_block_num)
%blockCombination - Combine turbo block
%
% Syntax:  [message] = blockCombination(message_cell,turbo_block_num)
%
% Input Arguments:
%    message_cell - user message
%    turbo_block_num - turbo Block Number
%
% Output Arguments:
%    message - user message

%----------------------------- BEGIN CODE ---------------------------------
if turbo_block_num > 1
    message = [];
    for i = 1:turbo_block_num
        message = [message,message_cell{i}(1:end-24)];
    end
    message = message(1:end-24);
else
    message = message_cell{1}(1:end-24);
end
end
%----------------------------- END OF CODE --------------------------------
