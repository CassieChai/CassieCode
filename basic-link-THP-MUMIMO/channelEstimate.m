function [h_est] = channelEstimate(grid_tran,grid_rece)
%channelEstimate - Downlink channel estimation 
%returns the estimated channel response between each transmit and receive antenna,hest, 
% 
% Syntax:  [h_est] = channelEstimate(grid_tran,grid_rece)
% 
% Input Arguments:
%    grid_tran - Resource grid before channel 
%    grid_rece - Resource grid after channel 
% 
% Output Arguments:
%    h_est - Estimated channel between transmit and receive antennas 

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
%% port0
temp0 = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);

% Reference signal on ofdm symbol0
index0_0 = find(mod(1:SUBCARRIER_NUM, 6) == 1);
temp0(index0_0,1) = grid_rece(index0_0,1)./grid_tran{1}(index0_0,1);

% Reference signal on ofdm symbol4
index0_4 = find(mod(1:SUBCARRIER_NUM, 6) == 4);
temp0(index0_4,5) = grid_rece(index0_4,5)./grid_tran{1}(index0_4,5);

% Reference signal on ofdm symbol7
index0_7 = find(mod(1:SUBCARRIER_NUM, 6) == 1);
temp0(index0_7,8) = grid_rece(index0_7,8)./grid_tran{1}(index0_7,8);

% Reference signal on ofdm symbol11
index0_11 = find(mod(1:SUBCARRIER_NUM, 6) == 4);
temp0(index0_11,12) = grid_rece(index0_11,12)./grid_tran{1}(index0_11,12);

% Estimate channel
sum0 = sum(temp0, 2)/2;
h0_est = interp1(1:3:SUBCARRIER_NUM,sum0(1:3:SUBCARRIER_NUM),1:SUBCARRIER_NUM,'linear','extrap');

%% port1
temp1 = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);

% Reference signal on ofdm symbol0
index1_0 = find(mod(1:SUBCARRIER_NUM, 6) == 4);
temp1(index1_0,1) = grid_rece(index1_0,1)./grid_tran{2}(index1_0,1);

% Reference signal on ofdm symbol4
index1_4 = find(mod(1:SUBCARRIER_NUM, 6) == 1);
temp1(index1_4,5) = grid_rece(index1_4,5)./grid_tran{2}(index1_4,5);

% Reference signal on ofdm symbol7
index1_7 = find(mod(1:SUBCARRIER_NUM, 6) == 4);
temp1(index1_7,8) = grid_rece(index1_7,8)./grid_tran{2}(index1_7,8);

% Reference signal on ofdm symbol11
index1_11 = find(mod(1:SUBCARRIER_NUM, 6) == 1);
temp1(index1_11,12) = grid_rece(index1_11,12)./grid_tran{2}(index1_11,12);

% estimate channel
sum1 = sum(temp1, 2)/2;
h1_est = interp1(1:3:SUBCARRIER_NUM,sum1(1:3:SUBCARRIER_NUM),1:SUBCARRIER_NUM,'linear','extrap');

%% port2
temp2 = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);

% Reference signal on ofdm symbol1
index2_1 = find(mod(1:SUBCARRIER_NUM, 6) == 1);
temp2(index2_1,2) = grid_rece(index2_1,2)./grid_tran{3}(index2_1,2);

% Reference signal on ofdm symbol8
index2_8 = find(mod(1:SUBCARRIER_NUM, 6) == 4);
temp2(index2_8,9) = grid_rece(index2_8,9)./grid_tran{3}(index2_8,9);

% estimate channel
sum2 = sum(temp2, 2);
h2_est = interp1(1:3:SUBCARRIER_NUM,sum2(1:3:SUBCARRIER_NUM),1:SUBCARRIER_NUM,'linear','extrap');
%% port3
temp3 = zeros(SUBCARRIER_NUM,OFDM_SYMBOL_NUM_PER_TTI);

% Reference signal on ofdm symbol1
index3_1 = find(mod(1:SUBCARRIER_NUM, 6) == 4);
temp3(index3_1,2) = grid_rece(index3_1,2)./grid_tran{4}(index3_1,2);

% Reference signal on ofdm symbol8
index3_8 = find(mod(1:SUBCARRIER_NUM, 6) == 1);
temp3(index3_8,9) = grid_rece(index3_8,9)./grid_tran{4}(index3_8,9);

% estimate channel
sum3 = sum(temp3, 2);
h3_est = interp1(1:3:SUBCARRIER_NUM,sum3(1:3:SUBCARRIER_NUM),1:SUBCARRIER_NUM,'linear','extrap');

h_est = conj([h0_est;h1_est;h2_est;h3_est]);
end
%----------------------------- END OF CODE --------------------------------
