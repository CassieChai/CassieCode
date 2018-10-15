function [out] = THP1Decode(h1,h2,h3,h4,in1,in2,in3,in4) %h:4*300 u:300*7
%THP - THP precoding
% 
% Syntax:  THP1Decode(h1,h2,h3,h4,in1,in2,in3,in4)
% 
% Input Arguments:
%    h1,h2,h3,h4 - Channel
%    u1,u2,u3,u4 - Signal
% 
% Output Arguments:
%    out - THP decoded data

%----------------------------- BEGIN CODE --------------------------------- 
loadConfig;
out = cell(TRAN_ANTENNA_NUM,1);% 4*1
in = cell(TRAN_ANTENNA_NUM,1);
y1 = cell(TRAN_ANTENNA_NUM,1);
for i = 1:TRAN_ANTENNA_NUM% 4
    out{i} = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);%300*7
    in{i} = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);
    y1{i} = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);
end
in{1}=in1;
in{2}=in2;
in{3}=in3;
in{4}=in4;

for i = 1:size(h1,2)%300
    H_real = [h1(:,i) h2(:,i) h3(:,i) h4(:,i)]';% 4*4
    H = [real(H_real),-imag(H_real);imag(H_real),real(H_real)];
    [Q1,R1] = qr(H');
    F1 = Q1; S1 = R1';
    G1 = inv(diag(diag(S1)));
    B1 = G1*S1;

    for j = 1:OFDM_SYMBOL_NUM_PER_TTI%7
        in_temp = zeros(TRAN_ANTENNA_NUM,1);
        y1_temp = zeros(TRAN_ANTENNA_NUM,1);
            for k = 1:TRAN_ANTENNA_NUM
                in_temp(k) = in{k}(i,j);
            end
        in_temp = [real(in_temp);imag(in_temp)];
        y1_temp = G1   * in_temp;
        for m = 1:TRAN_ANTENNA_NUM
            out{m}(i,j) = modulo(y1_temp(m) , MODULATION_ORDER)+1i*modulo(y1_temp(m+TRAN_ANTENNA_NUM) , MODULATION_ORDER);
        end
    end  
end

end