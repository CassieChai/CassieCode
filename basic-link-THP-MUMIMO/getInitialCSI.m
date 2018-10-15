function [h1_est,h2_est,h3_est,h4_est,feedback_codeword1_cell,feedback_codeword2_cell,feedback_codeword3_cell,feedback_codeword4_cell] = getInitialCSI(codebook,signal_power,noise_power_dB)
%getInitialCSI - get initial channel state information before first TTI
%
% Syntax:  [h1_est,h2_est,feedback_codeword1_cell,feedback_codeword2_cell] = getInitialCSI(codebook,signal_power,noise_power_dB)
%
% Input Arguments:
%    codebook - codebook
%    signal_power - signal power
%    noise_power_dB - noise power dB
%
% Output Arguments:
%    h1_est,h2_est - estimated channel
%    feedback_codeword1_cell,feedback_codeword2_cell - codeword

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
%% BC
resource_grid_tran_cell = {zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);...
    zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);...
    zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);...
    zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI)};

if PERFECT_ESTIMATION
    resource_grid_with_pilot_cell = resource_grid_tran_cell;
else
    resource_grid_with_pilot_cell = insertReferenceSignal(TTI_START,resource_grid_tran_cell,signal_power);
end

signal_tran_cell = cellfun(@(x) insertZeros(x),resource_grid_with_pilot_cell,...
    'UniformOutput',false);
%% Fading channel
% [signal1_rece,signal2_rece,h1_real,h2_real] = fadingChannel(1,signal_tran_cell);
[signal1_rece,signal2_rece,signal3_rece,signal4_rece,h1_real,h2_real,h3_real,h4_real] = fadingChannel(TTI_START,signal_tran_cell);
if NOISE_ADDED
	noise1 = wgn(size(signal1_rece,1),size(signal1_rece,2),noise_power_dB,'complex');
	noise2 = wgn(size(signal2_rece,1),size(signal2_rece,2),noise_power_dB,'complex');
	noise3 = wgn(size(signal3_rece,1),size(signal3_rece,2),noise_power_dB,'complex');
	noise4 = wgn(size(signal4_rece,1),size(signal4_rece,2),noise_power_dB,'complex');
	signal1_rece = signal1_rece + noise1;
	signal2_rece = signal2_rece + noise2;
	signal3_rece = signal3_rece + noise3;
	signal4_rece = signal4_rece + noise4;
end
%% UE
resource_grid1_rece = removeZeros(signal1_rece);
resource_grid2_rece = removeZeros(signal2_rece);
resource_grid3_rece = removeZeros(signal3_rece);
resource_grid4_rece = removeZeros(signal4_rece);

if PERFECT_ESTIMATION
	h1_est = removeZeros(h1_real.').';
	h2_est = removeZeros(h2_real.').';
	h3_est = removeZeros(h3_real.').';
	h4_est = removeZeros(h4_real.').';
else
	h1_est = channelEstimate(resource_grid_with_pilot_cell,resource_grid1_rece);
	h2_est = channelEstimate(resource_grid_with_pilot_cell,resource_grid2_rece);
	h3_est = channelEstimate(resource_grid_with_pilot_cell,resource_grid3_rece);
	h4_est = channelEstimate(resource_grid_with_pilot_cell,resource_grid4_rece);
end

feedback_codeword1_cell = channelQuantize(codebook,h1_est,CLOSET_CODEWORD_NUM);
feedback_codeword2_cell = channelQuantize(codebook,h2_est,CLOSET_CODEWORD_NUM);
feedback_codeword3_cell = channelQuantize(codebook,h3_est,CLOSET_CODEWORD_NUM);
feedback_codeword4_cell = channelQuantize(codebook,h4_est,CLOSET_CODEWORD_NUM);
end
%----------------------------- END OF CODE --------------------------------