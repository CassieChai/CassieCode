function [grid_with_zero] = insertZeros(grid)
%insertZeros - Insert zeros into resource grid
% 
% Syntax:  [grid_with_zero] = insertZeros(grid)
% 
% Input Arguments:
%    grid - grid need to insert zeros
% 
% Output Arguments:
%    grid_with_zero - grid after inserting zeros

%----------------------------- BEGIN CODE --------------------------------- 
loadConfig;
half_size_temp = (FFT_SIZE - SUBCARRIER_NUM)/2;
grid_with_zero = [zeros(half_size_temp,size(grid,2));grid;...
    zeros(half_size_temp,size(grid,2))];
end
%----------------------------- END OF CODE --------------------------------
