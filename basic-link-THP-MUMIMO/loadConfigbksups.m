% load default parameters
% version 1.1.1 
% origined by Zejian Li
% modified by Liutong Du @ 2018-06-06
% for PDSCH use Cell Specific Reference Signals



% Load Configuration
LINK_NAME = 'basic-link-THP';
% Simulation Config
SNR_VECTOR = 0:2:30;%SNR(dB)
SNR_NUM = length(SNR_VECTOR);
TTI_START = 1;
TTI_NUM = 999;
TTI_END = TTI_START+TTI_NUM;
% System Configuration
BAND_WIDTH = 12e5;% @5MHz
BANDwidthSC = 2e5;
CELL_ID = 0;
BS_NUM = 1; % number of base station
UE_NUM = 4; % number of UE
TRAN_ANTENNA_NUM = 4; % number of transmit antennas
RECE_ANTENNA_NUM = 1; % number of receive antennas
FEEDBACK_BIT_NUM = 4; % number of feedback bits
SUBFRAME_NUM_PER_FRAME = 10; % 1ms per sub-frame/ 10ms for per frame

% Resource Grid
MAX_RESOURCE_BLOCK_NUM = 110; % maxmimum number of Resource Block supported in LTE 
RESOURCE_BLOCK_NUM = BAND_WIDTH/BANDwidthSC; % (Frequency Domain)number of Resource Elements per Resource Block with a Carrier of 5MHz, with 12 sub-carrier in each element, 15KHz for each sub-carrier
SUBCARRIER_NUM_PER_RESOURCE_BLOCK = 12;
OFDM_SYMBOL_NUM_PER_SLOT = 7; % (Time Domain)number of OFDM symbols in a slot
OFDM_SYMBOL_NUM_PER_TTI = OFDM_SYMBOL_NUM_PER_SLOT*2; % Two slots per TTI
OFDM_SYMBOL_TO_MAPPING_SYMBOL = 1:14; % Sequence of OFDM symbol index
OFDM_SYMBOL_TO_INSERT_REFERENCE_SIGNAL = [1,2,5,8,9,12]; % Sequence of OFDM symbol index where we insert Cell Specific Reference Signals for Channel Estimation
RESOURCE_ELEMENT_NUM_PER_RESOURCE_BLOCK = 144; % 12*(14-2)-> OFDM symbols 0&1 are used to tranmit control information
RESOURCE_ELEMENT_NUM = RESOURCE_ELEMENT_NUM_PER_RESOURCE_BLOCK*RESOURCE_BLOCK_NUM;
SUBCARRIER_NUM = SUBCARRIER_NUM_PER_RESOURCE_BLOCK*RESOURCE_BLOCK_NUM;

% Modulation parameters
MODULATION_ORDER = 4;
N_RE_DATA = 128; % number of REs/OFDM symbols that could trans data(PDSCH CRS 4 antenna ports)
N_BITS_DATA = N_RE_DATA*MODULATION_ORDER; % number of data bits per RB can tranmit
N_BITS_TOTAL = N_BITS_DATA*RESOURCE_BLOCK_NUM; % number of total data bits can tranmit
CODE_RATE = 0.5;
switch MODULATION_ORDER
    case 2
        TRANSPORT_BLOCK_SIZE = 680;
    case 4
        TRANSPORT_BLOCK_SIZE = 5736;
end
% RATE_MATCH_SIZE = MODULATION_ORDER*RESOURCE_ELEMENT_NUM;
% CODE_RATE = (TRANSPORT_BLOCK_SIZE+24)/RATE_MATCH_SIZE;
CODEBOOK_TYPE = 'FFT';
CRC_MODE = '24A';
RATE_MATCH_SIZE = (TRANSPORT_BLOCK_SIZE+24)/CODE_RATE;%output length of rate match
RATE_MATCH_RV = 0;
FFT_SIZE = 512;




% Channel 
CHANNEL_PATH = 'C:\Users\Roger\Desktop\scm-512PointFFT-SEED3\';
%CHANNEL_PATH = 'C:\Users\RTT1\Desktop\RTT1¡¥¬∑-¿Ó‘ÛΩ°\scm-channel-512PointFFT-SEED2\';
NOISE_ADDED = true;
PERFECT_ESTIMATION = true;
CLOSET_CODEWORD_NUM = 2;

% Output data and figure
OUTPUT_PATH = ['C:\Users\Roger\Desktop\basic_link_VP\data'];
OUTPUT_DATA_PATH = ['C:\Users\Roger\Desktop\basic_link_VP\baselink_VP.mat'];
%OUTPUT_DATA_PATH = [LINK_NAME,'.mat'];