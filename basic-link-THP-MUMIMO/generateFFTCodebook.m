function [codebook_fft] = generateFFTCodebook(feedback_bit_num)
%generateFFTCodebook - generate fft codebook
% 
% Syntax:  [codebook_fft] = generateFFTCodebook(feedback_bit_num) 
% 
% Input Arguments:
%    feedback_bit_num - the scale of codebook  (2,4)
% 
% Output Arguments:
%    codebook_fft - fft codebook

%----------------------------- BEGIN CODE --------------------------------- 
switch feedback_bit_num
    case 2
        u = cell(1,4);
        u{1} = 1/sqrt(2)*[1 1].';
        u{2} = 1/sqrt(2)*[1 -1].';
        u{3} = 1/sqrt(2)*[1 1j].';
        u{4} = 1/sqrt(2)*[1 -1j].';
        codebook_fft = cell(1,4);
        for i = 1:4
            w = eye(4) - 2*u{i}*u{i}'/(u{i}'*u{i});
            codebook_fft{i} = w(:,1);
        end
    case 4
        u = cell(1,16);
        u{1} = [1 -1 -1 -1].';
        u{2} = [1 -1j 1 1j].';
        u{3} = [1 1 -1 1].';
        u{4} = [1 1j 1 -1j].';
        u{5} = [1 (-1-1j)/sqrt(2) -1j (1-1j)/sqrt(2)].';
        u{6} = [1 (1-1j)/sqrt(2) 1j (-1-1j)/sqrt(2)].';
        u{7} = [1 (1+1j)/sqrt(2) -1j (-1+1j)/sqrt(2)].';
        u{8} = [1 (-1+1j)/sqrt(2) 1j (1+1j)/sqrt(2)].';
        u{9} = [1 -1 1 1].';
        u{10} = [1 -1j -1 -1j].';
        u{11} = [1 1 1 -1].';
        u{12} = [1 1j -1 1j].';
        u{13} = [1 -1 -1 1].';
        u{14} = [1 -1 1 -1].';
        u{15} = [1 1 -1 -1].';
        u{16} = [1 1 1 1].';
        codebook_fft = cell(1,16);
        for i = 1:16
            w = eye(4) - 2*u{i}*u{i}'./(u{i}'*u{i});
            codebook_fft{i} = w(:,1);
        end
end
end
%----------------------------- END OF CODE --------------------------------