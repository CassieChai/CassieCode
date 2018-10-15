loadConfig;
disp('begin saving figure');
%Figure 1
filename1 = [OUTPUT_PATH,'average-throughput.jpg'];
saveas(1,filename1); 
filename1 = [OUTPUT_PATH,'average-throughput.fig'];
saveas(1,filename1);    
%Figure 2
filename2 = [OUTPUT_PATH,'ber.jpg'];
saveas(2,filename2); 
filename2 = [OUTPUT_PATH,'ber.fig'];
saveas(2,filename2); 
%Figure 3
filename3 = [OUTPUT_PATH,'bler.jpg'];
saveas(3,filename3); 
filename3 = [OUTPUT_PATH,'bler.fig'];
saveas(3,filename3); 
disp('finish saving figure');