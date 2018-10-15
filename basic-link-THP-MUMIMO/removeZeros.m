function [grid_wo_zero] = removeZeros(grid)
%removeZeros - remove zeros from resource grid
% 
% Syntax:  [grid_wo_zero] = removeZeros(grid)
% 
% Input Arguments:
%    grid - input grid   
% 
% Output Arguments:
%    grid_wo_zero - grid without zero

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
half_size_tmp = (FFT_SIZE - SUBCARRIER_NUM)/2;
grid_wo_zero = grid(half_size_tmp+1:end-half_size_tmp,:);
end

