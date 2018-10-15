function [x] = mimoEncode(w1,w2,w3,w4,u1,u2,u3,u4,message1_power,message2_power,message3_power,message4_power)
%mimoEncode - perform mimo encode  x = w1*u1+w2*u2
%
% Syntax:  [x] = mimoEncode(w1,w2,u1,u2,message1_power,message2_power)
%
% Input Arguments:
%    w1 - Precoding for user1
%    w2 - Precoding for user2
%    u1 - Data for user1
%    u2 - Data for user2
%    message1_power - Power for user1
%    message2_power - Power for user2
%
% Output Arguments:
%    x - MIMO encoded data

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
x = cell(TRAN_ANTENNA_NUM,1);
for i = 1:TRAN_ANTENNA_NUM
    x{i} = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);
end
for i = 1:SUBCARRIER_NUM
    for j = 1:OFDM_SYMBOL_NUM_PER_TTI
        temp = w1(:,i)*u1(i,j)*sqrt(message1_power) + w2(:,i)*u2(i,j)*sqrt(message2_power) + w3(:,i)*u3(i,j)*sqrt(message3_power) + w4(:,i)*u4(i,j)*sqrt(message4_power);
        for k = 1:TRAN_ANTENNA_NUM
            x{k}(i,j) = temp(k);
        end
    end
end
end
%----------------------------- END OF CODE --------------------------------
