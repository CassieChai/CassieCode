function [codeword_cell] = channelQuantize(codebook,h,num)
%channelQuantize - quantize channel using codebook
% 
% Syntax: [codeword_cell] = channelQuantize(codebook,h,num)
% 
% Input Arguments:
%    codebook - precoding codebook 
%    h - channel 
%    num - Number of matched codeword
% 
% Output Arguments:
%    codeword_cell - Quantized channel 

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
codeword_cell = cell(1,SUBCARRIER_NUM);
for sc_idx = 1:SUBCARRIER_NUM
    R = h(:,sc_idx)*h(:,sc_idx)';
    results = cellfun(@(x) abs(x'*R*x),codebook);
    [~, sorted_idx] = sort(results,'descend');
    codeword_cell{sc_idx} = {codebook{sorted_idx(1:num)}};
end
end
%----------------------------- END OF CODE --------------------------------
