function [symbol] = getSymbolFromResourceGrid(grid,symbol_num)
%getSymbolFromResourceGrid - Get user symbol from resource elements
% 
% Syntax:  [symbol] = getSymbolFromResourceGrid(grid,symbol_num)
% 
% Input Arguments:
%    grid - resource grid 
%    symbol_num - Symbol number
% 
% Output Arguments:
%    symbol - user symbol 

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
symbol = zeros(1,symbol_num);
curr_num = 0;
for i = 1:length(OFDM_SYMBOL_TO_MAPPING_SYMBOL)
    symbol_idx = OFDM_SYMBOL_TO_MAPPING_SYMBOL(i);
    if ismember(symbol_idx,OFDM_SYMBOL_TO_INSERT_REFERENCE_SIGNAL)
        for sc_idx = 1:SUBCARRIER_NUM
            if mod(sc_idx,3) ~= 1
                curr_num = curr_num + 1;
                symbol(curr_num) = grid(sc_idx,symbol_idx);
                if curr_num == symbol_num
                    return
                end
            end
        end
    else
        for sc_idx = 1:SUBCARRIER_NUM
            curr_num = curr_num + 1;
            symbol(curr_num) = grid(sc_idx,symbol_idx);
            if curr_num == symbol_num
                return
            end
        end
    end
end
end
%----------------------------- END OF CODE --------------------------------
