function [resource_grid] = mappingToResourceElement(symbol_in,symbol_num)
%mappingToResourceElement - mapping symbol to resource element
%The mapping to resource elements (k,l) should be in increasing order of 
%first index k and then index l.
%
% Syntax:  [resource_grid] = mappingToResourceElement(symbol_in,symbol_num)
%
% Input Arguments:
%    symbol_in - Symbol after mimo encoded
%    symbol_num - Symbol number
%
% Output Arguments:
%    resource_grid - Resource grid

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
resource_grid = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);
curr_num = 0;
for i = 1:length(OFDM_SYMBOL_TO_MAPPING_SYMBOL)
    symbol_idx = OFDM_SYMBOL_TO_MAPPING_SYMBOL(i);
    if ismember(symbol_idx,OFDM_SYMBOL_TO_INSERT_REFERENCE_SIGNAL)
        for sc_idx = 1:SUBCARRIER_NUM
            if mod(sc_idx,3) ~= 1
                curr_num = curr_num + 1;
                resource_grid(sc_idx,symbol_idx) = symbol_in(curr_num);
                if curr_num == symbol_num
                    return;
                end
            end
        end
    else
        for sc_idx = 1:SUBCARRIER_NUM
            curr_num = curr_num + 1;
            resource_grid(sc_idx,symbol_idx) = symbol_in(curr_num);
            if curr_num == symbol_num
                return;
            end
        end
    end
end
end
%----------------------------- END OF CODE --------------------------------