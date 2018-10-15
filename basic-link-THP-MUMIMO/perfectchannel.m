function [h1_est,h2_est,h3_est,h4_est] = perfectchannel(tti_idx)
    loadConfig;
    
    filename = [CHANNEL_PATH,'TTI',num2str(tti_idx),'BS4'];
    load(filename,'h1','h2','h3','h4');
    h1_real = h1;%4x512
    h2_real = h2;
    h3_real = h3;
    h4_real = h4;
    h1_real = removeZeros(h1_real.').';
    h2_real = removeZeros(h2_real.').';
    h3_real = removeZeros(h3_real.').';
    h4_real = removeZeros(h4_real.').';
    h1_est = h1_real;
    h2_est = h2_real;
    h3_est = h3_real;
    h4_est = h4_real;
    
end