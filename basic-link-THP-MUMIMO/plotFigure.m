loadConfig;


disp('begin ploting figure');
%%
figure(1);
plot(SNR_VECTOR,average_throughput1_vector./500,'-s',SNR_VECTOR,average_throughput2_vector./500,'-o',SNR_VECTOR,average_throughput3_vector./500,'-*',SNR_VECTOR,average_throughput4_vector./500,'-^');
grid on;
title(['throughput for ',LINK_NAME]);
xlabel('SNR(dB)');
ylabel('throughput(bit/s/Hz)');
set(gca,'XLim',[SNR_VECTOR(1),SNR_VECTOR(end)]);
legend('user1','user2','user3','user4');

figure(2);
semilogy(SNR_VECTOR,ber1_vector,'-s',SNR_VECTOR,ber2_vector,'-o',SNR_VECTOR,ber3_vector,'-*',SNR_VECTOR,ber4_vector,'-^');
grid on;
title(['ber for ',LINK_NAME]);
xlabel('SNR(dB)');
ylabel('BER');
set(gca,'XLim',[SNR_VECTOR(1),SNR_VECTOR(end)]);
temp1 = ber1_vector;
temp2 = ber2_vector;
temp1(temp1 == 0) = [];
temp2(temp2 == 0) = [];
set(gca,'YLim',[min([temp1,temp2])/10,1]);
legend('user1','user2','user3','user4');

figure(3);
semilogy(SNR_VECTOR,bler1_vector,'-s',SNR_VECTOR,bler2_vector,'-o',SNR_VECTOR,bler3_vector,'-*',SNR_VECTOR,bler4_vector,'-^');
grid on;
title(['bler for ',LINK_NAME]);
xlabel('SNR(dB)');
ylabel('BLER');
set(gca,'XLim',[SNR_VECTOR(1),SNR_VECTOR(end)]);
temp1 = bler1_vector;
temp2 = bler2_vector;
temp3 = bler3_vector;
temp4 = bler4_vector;
temp1(temp1 == 0) = [];
temp2(temp2 == 0) = [];
temp3(temp3 == 0) = [];
temp4(temp4 == 0) = [];
set(gca,'YLim',[min([temp1,temp2,temp3,temp4])/10,1]);
legend('user1','user2','user3','user4');
%%
figure(4);
BLER = (bler1_vector+bler2_vector+bler3_vector+bler4_vector)/4;
semilogy(SNR_VECTOR,BLER,'-o');
grid on;
title(['bler for ',LINK_NAME]);
xlabel('SNR(dB)');
ylabel('BLER');
set(gca,'XLim',[SNR_VECTOR(1),SNR_VECTOR(end)]);
temp1 = (bler1_vector+bler2_vector+bler3_vector+bler4_vector)/4;
temp1(temp1 == 0) = [];
set(gca,'YLim',[min([temp1])/10,1]);
legend('BLER');
%%
disp('finish ploting figure');