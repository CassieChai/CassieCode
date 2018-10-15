function [signal1_rece,signal2_rece,signal3_rece,signal4_rece,h1_real,h2_real,h3_real,h4_real] = fadingChannel(tti_idx,signal_tran_cell)
%fadingChannel - go through fading channel
%
% Syntax:  [signal1_rece,signal2_rece,h1_real,h2_real] = fadingChannel(tti_idx,signal_tran)
%
% Input Arguments:
%    tti_idx - The No. of TTI
%    signal_tran_cell - Transmit signal
%
% Output Arguments:
%    signal1_rece,signal2_rece - Receive signal
%    h1_real,h2_real - Real channel

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;

% Load Channel
filename = [CHANNEL_PATH,'TTI',num2str(tti_idx),'BS4'];
load(filename,'h1','h2','h3','h4');
h1_real = h1;%4x512
h2_real = h2;
h3_real = h3;
h4_real = h4;

% Fading channel
signal1_rece = zeros(size(signal_tran_cell{1}));
signal2_rece = zeros(size(signal_tran_cell{1}));
signal3_rece = zeros(size(signal_tran_cell{1}));
signal4_rece = zeros(size(signal_tran_cell{1}));
for i = 1:size(h1,2)
    for j = 1:size(signal_tran_cell{1},2)
        x = zeros(TRAN_ANTENNA_NUM,1);
        for k = 1:TRAN_ANTENNA_NUM
            x(k) = signal_tran_cell{k}(i,j);
        end
        signal1_rece(i,j) = h1_real(:,i)'*x;
        signal2_rece(i,j) = h2_real(:,i)'*x;
		signal3_rece(i,j) = h3_real(:,i)'*x;
        signal4_rece(i,j) = h4_real(:,i)'*x;
    end
end





end
%----------------------------- END OF CODE --------------------------------