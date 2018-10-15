function [codebook_rvq] = generateRVQCodebook(tran_antenna_num,feedback_bit_num)
%generateRVQCodebook - generate rvq codebook
% 
% Syntax:  [codebook_rvq] = generateRVQCodebook(tran_antenna_num,feedback_bit_num) 
% 
% Input Arguments:
%    tran_antenna_num - transmit antenna num 
%    feedback_bit_num - feedback bit num 
% 
% Output Arguments:
%    codebook_rvq - codebook 

%----------------------------- BEGIN CODE --------------------------------- 
codebook_rvq = cell(1,2^feedback_bit_num);
for k = 1:2^feedback_bit_num
    v = rand(tran_antenna_num,1) + 1j*rand(tran_antenna_num,1);
    codebook_rvq{k} = v/norm(v);
end
end