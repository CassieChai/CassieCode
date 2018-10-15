function [precoding11,precoding12] = findBestCodewordCouple(h1_est,h2_est,...
            feedback_codeword1_cell,feedback_codeword2_cell)
%findBestCodewordCouple - find best codeword couple to make sum SNR better
% 
% Syntax:  [precoding11,precoding12] = findBestCodewordCouple(h_est1,h_est2,feedback_codeword1_cell,feedback_codeword2_cell)
% 
% Input Arguments:
%    h_est1,h_est2 - Estimated channel 
%    feedback_codeword1_cell,feedback_codeword2_cell - User codeward 
% 
% Output Arguments:
%    precoding11,precoding12 - best codeward couple  

%----------------------------- BEGIN CODE --------------------------------- 
precoding11 = zeros(size(h1_est));
precoding12 = zeros(size(h2_est));
for iSC = 1:size(feedback_codeword1_cell,2)
    feedback_codeword1_cell1 = feedback_codeword1_cell{iSC}{1};
    feedback_codeword1_cell2 = feedback_codeword1_cell{iSC}{2};
    feedback_codeword2_cell1 = feedback_codeword2_cell{iSC}{1};
    feedback_codeword2_cell2 = feedback_codeword2_cell{iSC}{2};
    if feedback_codeword1_cell1 == feedback_codeword2_cell1
        sumSNR1 = abs(h1_est(:,iSC)'*feedback_codeword1_cell1)^2+abs(h2_est(:,iSC)'*feedback_codeword2_cell2)^2;
        sumSNR2 = abs(h1_est(:,iSC)'*feedback_codeword1_cell2)^2+abs(h2_est(:,iSC)'*feedback_codeword2_cell1)^2;
        if sumSNR1 > sumSNR2
            precoding11(:,iSC) = feedback_codeword1_cell1;
            precoding12(:,iSC) = feedback_codeword2_cell2;
        elseif sumSNR1 < sumSNR2
            precoding11(:,iSC) = feedback_codeword1_cell2;
            precoding12(:,iSC) = feedback_codeword2_cell1;
        else
            if rand >= 0.5
                precoding11(:,iSC) = feedback_codeword1_cell1;
                precoding12(:,iSC) = feedback_codeword2_cell2;
            else
                precoding11(:,iSC) = feedback_codeword1_cell2;
                precoding12(:,iSC) = feedback_codeword2_cell1;
            end
        end
    else
        precoding11(:,iSC) = feedback_codeword1_cell1;
        precoding12(:,iSC) = feedback_codeword2_cell1;
    end
end
end
%----------------------------- END OF CODE --------------------------------
