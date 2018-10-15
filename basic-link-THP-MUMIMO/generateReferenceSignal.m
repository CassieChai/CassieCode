function [reference_signal] = generateReferenceSignal(n_s,l)
%generateReferenceSignal - generate reference signal 
% 
% Syntax:  [reference_signal] = generateReferenceSignal(n_s,l)
% 
% Input Arguments:
%    n_s - slot number within a radio frame 
%    l - ofdm symbol number within the slot  
% 
% Output Arguments:
%    reference_signal - reference signal 

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
N_cp = 1;

c_init = 2^10*(7*(n_s+1)+l+1)*(2*CELL_ID+1)+2*CELL_ID+N_cp;
c = generatePseudoRandomSequence(c_init,MAX_RESOURCE_BLOCK_NUM*4);
reference_signal = (1-2*c(:,1:2:end))/sqrt(2)+1j*(1-2*c(:,2:2:end))/sqrt(2);
end
%----------------------------- END OF CODE --------------------------------
