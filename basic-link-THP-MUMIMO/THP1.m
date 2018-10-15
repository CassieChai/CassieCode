function [Tx_signal_THP1] = THP1(h1,h2,h3,h4,u1,u2,u3,u4) %h:4*300 u:300*7

%THP - THP precoding
% 
% Syntax:  [Tx_signal_THP1] = THP1(h1,h2,h3,h4,u1,u2,u3,u4)
% 
% Input Arguments:
%    h1,h2,h3,h4 - Channel
%    u1,u2,u3,u4 - Signal
% 
% Output Arguments:
%    Tx_signal_THP - THP encoded data

%----------------------------- BEGIN CODE --------------------------------- 
loadConfig;
Tx_signal_THP1 = cell(TRAN_ANTENNA_NUM,1);% 4*1
U = cell(TRAN_ANTENNA_NUM,1);
for i = 1:TRAN_ANTENNA_NUM% 4
    Tx_signal_THP1{i} = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);%300*7
    U{i} = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);
end
U{1}=u1;
U{2}=u2;
U{3}=u3;
U{4}=u4;
x1{1}=real(u1);
x1{2}=real(u2);
x1{3}=real(u3);
x1{4}=real(u4);
x1{5}=imag(u1);
x1{6}=imag(u2);
x1{7}=imag(u3);
x1{8}=imag(u4);

for i = 1:size(h1,2)%300
    H_real = [h1(:,i) h2(:,i) h3(:,i) h4(:,i)]';% 4*4
    H = [real(H_real),-imag(H_real);imag(H_real),real(H_real)];
    [Q1,R1] = qr(H');
    F1 = Q1; S1 = R1';
    G1 = inv(diag(diag(S1)));
    B1 = G1*S1;

    for j = 1:OFDM_SYMBOL_NUM_PER_TTI  %7
        
        for m = 2:TRAN_ANTENNA_NUM*2 
            temp = zeros(m-1,1);
            for k = 1:m-1
                temp(k) = x1{k}(i,j);
            end
            x1{m}(i,j) = modulo(x1{m}(i,j) - B1(m,1:m-1) * temp,MODULATION_ORDER);
        end
         xp = [x1{1}(i,j) x1{2}(i,j) x1{3}(i,j) x1{4}(i,j) x1{5}(i,j) x1{6}(i,j) x1{7}(i,j) x1{8}(i,j)]';
         x = F1*xp;
        x1{1}(i,j) = x(1)+1i*x(5);
        x1{2}(i,j) = x(2)+1i*x(6);
        x1{3}(i,j) = x(3)+1i*x(7);
        x1{4}(i,j) = x(4)+1i*x(8);
    end  
end

Tx_signal_THP1 = x1;



end
%----------------------------- END OF CODE --------------------------------