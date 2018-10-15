% Two-receiver MISO BC system
clear;clc;
dbstop if error
profile on
%% System Configuration and Performance Parameter
loadConfig;

signal_power_vector = zeros(1,SNR_NUM);
noise_power_dB_vector = zeros(1,SNR_NUM);

message1_power_cell = cell(1,SNR_NUM);
message2_power_cell = cell(1,SNR_NUM);
message3_power_cell = cell(1,SNR_NUM);
message4_power_cell = cell(1,SNR_NUM);
total_bit_num1_cell = cell(1,SNR_NUM);
total_bit_num2_cell = cell(1,SNR_NUM);
total_bit_num3_cell = cell(1,SNR_NUM);
total_bit_num4_cell = cell(1,SNR_NUM);
throughput1_cell = cell(1,SNR_NUM);
throughput2_cell = cell(1,SNR_NUM);
throughput3_cell = cell(1,SNR_NUM);
throughput4_cell = cell(1,SNR_NUM);
average_throughput1_vector = zeros(1,SNR_NUM);
average_throughput2_vector = zeros(1,SNR_NUM);
average_throughput3_vector = zeros(1,SNR_NUM);
average_throughput4_vector = zeros(1,SNR_NUM);
error_bit_num1_cell = cell(1,SNR_NUM);
error_bit_num2_cell = cell(1,SNR_NUM);
error_bit_num3_cell = cell(1,SNR_NUM);
error_bit_num4_cell = cell(1,SNR_NUM);
ber1_vector = zeros(1,SNR_NUM);
ber2_vector = zeros(1,SNR_NUM);
ber3_vector = zeros(1,SNR_NUM);
ber4_vector = zeros(1,SNR_NUM);
error_block_num1_cell = cell(1,SNR_NUM);
error_block_num2_cell = cell(1,SNR_NUM);
error_block_num3_cell = cell(1,SNR_NUM);
error_block_num4_cell = cell(1,SNR_NUM);
bler1_vector = zeros(1,SNR_NUM);
bler2_vector = zeros(1,SNR_NUM);
bler3_vector = zeros(1,SNR_NUM);
bler4_vector = zeros(1,SNR_NUM);
%% DownLink
switch CODEBOOK_TYPE
    case 'FFT'
        codebook = generateFFTCodebook(FEEDBACK_BIT_NUM);
    case 'RVQ'
        codebook = generateRVQCodebook(TRAN_ANTENNA_NUM,FEEDBACK_BIT_NUM);
end



parfor snr_idx = 1:SNR_NUM
    snr = SNR_VECTOR(snr_idx);
    signal_power = 10^(snr/10);
    noise_power_dB = -snr;
    
    message1_power_vector = zeros(1,TTI_NUM);
    message2_power_vector = zeros(1,TTI_NUM);
	message3_power_vector = zeros(1,TTI_NUM);
    message4_power_vector = zeros(1,TTI_NUM);
    total_bit_num1_vector = zeros(1,TTI_NUM);
    total_bit_num2_vector = zeros(1,TTI_NUM);
	total_bit_num3_vector = zeros(1,TTI_NUM);
    total_bit_num4_vector = zeros(1,TTI_NUM);
    throughput1_vector = zeros(1,TTI_NUM);
    throughput2_vector = zeros(1,TTI_NUM);
	throughput3_vector = zeros(1,TTI_NUM);
    throughput4_vector = zeros(1,TTI_NUM);
    error_bit_num1_vector = zeros(1,TTI_NUM);
    error_bit_num2_vector = zeros(1,TTI_NUM);
	error_bit_num3_vector = zeros(1,TTI_NUM);
    error_bit_num4_vector = zeros(1,TTI_NUM);
    error_block_num1_vector = zeros(1,TTI_NUM);
    error_block_num2_vector = zeros(1,TTI_NUM);
	error_block_num3_vector = zeros(1,TTI_NUM);
    error_block_num4_vector = zeros(1,TTI_NUM);
    
    [h1_est,h2_est,h3_est,h4_est,feedback_codeword1_cell,feedback_codeword2_cell,feedback_codeword3_cell,feedback_codeword4_cell] = getInitialCSI(codebook,signal_power,noise_power_dB);
    
    for tti_idx = 1:TTI_NUM
        %% BS
        tic
        if PERFECT_ESTIMATION
            
            [h1_est,h2_est,h3_est,h4_est] = perfectchannel(tti_idx+TTI_START);
            codeword1 = h1_est;
            codeword2 = h2_est;
            codeword3 = h3_est;
            codeword4 = h4_est;
        else
            [codeword1,codeword2] = findBestCodewordCouple(h1_est,h2_est, feedback_codeword1_cell,feedback_codeword2_cell);
            [codeword3,codeword4] = findBestCodewordCouple(h3_est,h4_est, feedback_codeword3_cell,feedback_codeword4_cell);
        end
       
        message1_power = signal_power/4;
        message2_power = signal_power/4;
		message3_power = signal_power/4;
        message4_power = signal_power/4;
		
        message1_power_vector(tti_idx) = message1_power;
        message2_power_vector(tti_idx) = message2_power;
        message3_power_vector(tti_idx) = message3_power;
        message4_power_vector(tti_idx) = message4_power;
		
        message1_tran = randi([0,1],1,TRANSPORT_BLOCK_SIZE);
        message2_tran = randi([0,1],1,TRANSPORT_BLOCK_SIZE);
		message3_tran = randi([0,1],1,TRANSPORT_BLOCK_SIZE);
        message4_tran = randi([0,1],1,TRANSPORT_BLOCK_SIZE);
        total_bit_num1_vector(tti_idx) = TRANSPORT_BLOCK_SIZE;
        total_bit_num2_vector(tti_idx) = TRANSPORT_BLOCK_SIZE;
		total_bit_num3_vector(tti_idx) = TRANSPORT_BLOCK_SIZE;
        total_bit_num4_vector(tti_idx) = TRANSPORT_BLOCK_SIZE;
        
        crc1 = crcEncode(message1_tran,CRC_MODE);
        crc2 = crcEncode(message2_tran,CRC_MODE);
		crc3 = crcEncode(message3_tran,CRC_MODE);
        crc4 = crcEncode(message4_tran,CRC_MODE);
        
        [crc1_cell,rate_recover_size_cell,turbo_block_num] = blockSegment(crc1);
        [crc2_cell,~,~] = blockSegment(crc2);
		[crc3_cell,~,~] = blockSegment(crc3);
		[crc4_cell,~,~] = blockSegment(crc4);
        if turbo_block_num > 1
            crc1_cell = cellfun(@(x) crcEncode(x,CRC_MODE),crc1_cell,'UniformOutput',false);
            crc2_cell = cellfun(@(x) crcEncode(x,CRC_MODE),crc2_cell,'UniformOutput',false);
			crc3_cell = cellfun(@(x) crcEncode(x,CRC_MODE),crc3_cell,'UniformOutput',false);
            crc4_cell = cellfun(@(x) crcEncode(x,CRC_MODE),crc4_cell,'UniformOutput',false);
        end
        
        turbo1_cell = cellfun(@(x) lteTurboEncode(x),crc1_cell,'UniformOutput',false);
        turbo2_cell = cellfun(@(x) lteTurboEncode(x),crc2_cell,'UniformOutput',false);
		turbo3_cell = cellfun(@(x) lteTurboEncode(x),crc3_cell,'UniformOutput',false);
        turbo4_cell = cellfun(@(x) lteTurboEncode(x),crc4_cell,'UniformOutput',false);
        
        rate_match1_cell = cellfun(@(x) lteRateMatchTurbo(x,RATE_MATCH_SIZE,RATE_MATCH_RV), turbo1_cell,'UniformOutput',false);
        rate_match2_cell = cellfun(@(x) lteRateMatchTurbo(x,RATE_MATCH_SIZE,RATE_MATCH_RV), turbo2_cell,'UniformOutput',false);
		rate_match3_cell = cellfun(@(x) lteRateMatchTurbo(x,RATE_MATCH_SIZE,RATE_MATCH_RV), turbo3_cell,'UniformOutput',false);
        rate_match4_cell = cellfun(@(x) lteRateMatchTurbo(x,RATE_MATCH_SIZE,RATE_MATCH_RV), turbo4_cell,'UniformOutput',false);
        rate_match1 = cell2mat(rate_match1_cell);
        rate_match2 = cell2mat(rate_match2_cell);
		rate_match3 = cell2mat(rate_match3_cell);
        rate_match4 = cell2mat(rate_match4_cell);
        
        symbol_tran1 = symbolModulate(rate_match1,MODULATION_ORDER);
        symbol_tran2 = symbolModulate(rate_match2,MODULATION_ORDER);
		symbol_tran3 = symbolModulate(rate_match3,MODULATION_ORDER);
        symbol_tran4 = symbolModulate(rate_match4,MODULATION_ORDER);
        
        symbol_num = length(symbol_tran1);
        user_grid_tran1 = mappingToResourceElement(symbol_tran1,symbol_num);
        user_grid_tran2 = mappingToResourceElement(symbol_tran2,symbol_num);
		user_grid_tran3 = mappingToResourceElement(symbol_tran3,symbol_num);
        user_grid_tran4 = mappingToResourceElement(symbol_tran4,symbol_num);
        
        %ZF precoding
		% [precoding1,precoding2,precoding3,precoding4] = zeroForcingBeamforming(codeword1,codeword2,codeword3,codeword4);
        % resource_grid1_tran_cell = mimoEncode(precoding1,precoding2,precoding3,precoding4,user_grid_tran1,user_grid_tran2,user_grid_tran3,user_grid_tran4,message1_power,message2_power,message3_power,message4_power);
		        		
        %THP precoding
    	[resource_grid1_tran_cell] =  THP1(codeword1,codeword2,codeword3,codeword4,user_grid_tran1,user_grid_tran2,user_grid_tran3,user_grid_tran4);

        if PERFECT_ESTIMATION
            resource_grid_with_pilot_cell = resource_grid1_tran_cell;
        else
            resource_grid_with_pilot_cell = insertReferenceSignal(tti_idx+TTI_START,resource_grid1_tran_cell,signal_power);
        end
        signal_tran_cell = cellfun(@(x) insertZeros(x),resource_grid_with_pilot_cell, 'UniformOutput',false);
        %% Physical Channel
        [signal1_rece,signal2_rece,signal3_rece,signal4_rece,h1_real,h2_real,h3_real,h4_real] = fadingChannel(tti_idx+TTI_START,signal_tran_cell);
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
        
        h1_real = removeZeros(h1_real.').';
        h2_real = removeZeros(h2_real.').';
        h3_real = removeZeros(h3_real.').';
        h4_real = removeZeros(h4_real.').';
		
        if PERFECT_ESTIMATION
            h1_est = h1_real;
            h2_est = h2_real;
			h3_est = h3_real;
            h4_est = h4_real;
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
        % MIMO decoding
		% y = mimoDecode_VP(resource_grid1_rece,resource_grid2_rece,resource_grid3_rece,resource_grid4_rece,Beta_VP);
        y = THP1Decode(h1_est,h2_est,h3_est,h4_est,resource_grid1_rece,resource_grid2_rece,resource_grid3_rece,resource_grid4_rece);
        user_grid1_tran = y{1};
        user_grid2_tran = y{2};
		user_grid3_tran = y{3};
        user_grid4_tran = y{4};
        
        symbol1_rece = getSymbolFromResourceGrid(user_grid1_tran,symbol_num);
        symbol2_rece = getSymbolFromResourceGrid(user_grid2_tran,symbol_num);
		symbol3_rece = getSymbolFromResourceGrid(user_grid3_tran,symbol_num);
        symbol4_rece = getSymbolFromResourceGrid(user_grid4_tran,symbol_num);
        
        symbol_demodu1 = symbolDemodulate(symbol1_rece,MODULATION_ORDER);
        symbol_demodu2 = symbolDemodulate(symbol2_rece,MODULATION_ORDER);
		symbol_demodu3 = symbolDemodulate(symbol3_rece,MODULATION_ORDER);
        symbol_demodu4 = symbolDemodulate(symbol4_rece,MODULATION_ORDER);
        symbol_demodu1_cell = mat2cell(symbol_demodu1,1,ones(1,turbo_block_num)*RATE_MATCH_SIZE).';
        symbol_demodu2_cell = mat2cell(symbol_demodu2,1,ones(1,turbo_block_num)*RATE_MATCH_SIZE).';
		symbol_demodu3_cell = mat2cell(symbol_demodu3,1,ones(1,turbo_block_num)*RATE_MATCH_SIZE).';
        symbol_demodu4_cell = mat2cell(symbol_demodu4,1,ones(1,turbo_block_num)*RATE_MATCH_SIZE).';
			
        
        rate_recover1_cell = cellfun(@(x,y) lteRateRecoverTurbo(x,y,0),symbol_demodu1_cell,rate_recover_size_cell);
        rate_recover2_cell = cellfun(@(x,y) lteRateRecoverTurbo(x,y,0),symbol_demodu2_cell,rate_recover_size_cell);
		rate_recover3_cell = cellfun(@(x,y) lteRateRecoverTurbo(x,y,0),symbol_demodu3_cell,rate_recover_size_cell);
        rate_recover4_cell = cellfun(@(x,y) lteRateRecoverTurbo(x,y,0),symbol_demodu4_cell,rate_recover_size_cell);	
        
        message1_rece_cell = cellfun(@(x) lteTurboDecode(x).',rate_recover1_cell,'UniformOutput',false).';
        message2_rece_cell = cellfun(@(x) lteTurboDecode(x).',rate_recover2_cell,'UniformOutput',false).';
		message3_rece_cell = cellfun(@(x) lteTurboDecode(x).',rate_recover3_cell,'UniformOutput',false).';
        message4_rece_cell = cellfun(@(x) lteTurboDecode(x).',rate_recover4_cell,'UniformOutput',false).';
        
        message1_rece = blockCombination(message1_rece_cell,turbo_block_num);
        message2_rece = blockCombination(message2_rece_cell,turbo_block_num);
		message3_rece = blockCombination(message3_rece_cell,turbo_block_num);
        message4_rece = blockCombination(message4_rece_cell,turbo_block_num);
        
        error_bit_num1 = biterr(message1_rece,message1_tran);
        error_bit_num2 = biterr(message2_rece,message2_tran);
		error_bit_num3 = biterr(message3_rece,message3_tran);
        error_bit_num4 = biterr(message4_rece,message4_tran);
        error_block_num1 = 1*(error_bit_num1>0);
        error_block_num2 = 1*(error_bit_num2>0);
		error_block_num3 = 1*(error_bit_num3>0);
        error_block_num4 = 1*(error_bit_num4>0);
        error_bit_num1_vector(tti_idx) = error_bit_num1;
        error_bit_num2_vector(tti_idx) = error_bit_num2;
		error_bit_num3_vector(tti_idx) = error_bit_num3;
        error_bit_num4_vector(tti_idx) = error_bit_num4;
        error_block_num1_vector(tti_idx) = error_block_num1;
        error_block_num2_vector(tti_idx) = error_block_num2;
		error_block_num3_vector(tti_idx) = error_block_num3;
        error_block_num4_vector(tti_idx) = error_block_num4;
        throughput1_vector(tti_idx) = (1-error_block_num1)*TRANSPORT_BLOCK_SIZE;
        throughput2_vector(tti_idx) = (1-error_block_num2)*TRANSPORT_BLOCK_SIZE;
		throughput3_vector(tti_idx) = (1-error_block_num3)*TRANSPORT_BLOCK_SIZE;
        throughput4_vector(tti_idx) = (1-error_block_num4)*TRANSPORT_BLOCK_SIZE;
        toc
    end
    signal_power_vector(snr_idx) = signal_power;
    noise_power_dB_vector(snr_idx) = noise_power_dB;
    message1_power_cell{snr_idx} = message1_power_vector;
    message2_power_cell{snr_idx} = message2_power_vector;
	message3_power_cell{snr_idx} = message3_power_vector;
    message4_power_cell{snr_idx} = message4_power_vector;
    total_bit_num1_cell{snr_idx} = total_bit_num1_vector;
    total_bit_num2_cell{snr_idx} = total_bit_num2_vector;
	total_bit_num3_cell{snr_idx} = total_bit_num3_vector;
    total_bit_num4_cell{snr_idx} = total_bit_num4_vector;
    throughput1_cell{snr_idx} = throughput1_vector;
    throughput2_cell{snr_idx} = throughput2_vector;
	throughput3_cell{snr_idx} = throughput3_vector;
    throughput4_cell{snr_idx} = throughput4_vector;
    average_throughput1_vector(snr_idx) = sum(throughput1_vector)/TTI_NUM;
    average_throughput2_vector(snr_idx) = sum(throughput2_vector)/TTI_NUM;
	average_throughput3_vector(snr_idx) = sum(throughput3_vector)/TTI_NUM;
    average_throughput4_vector(snr_idx) = sum(throughput4_vector)/TTI_NUM;
    error_bit_num1_cell{snr_idx} = error_bit_num1_vector;
    error_bit_num2_cell{snr_idx} = error_bit_num2_vector;
	error_bit_num3_cell{snr_idx} = error_bit_num3_vector;
    error_bit_num4_cell{snr_idx} = error_bit_num4_vector;
    ber1_vector(snr_idx) = sum(error_bit_num1_vector)/sum(total_bit_num1_vector);
    ber2_vector(snr_idx) = sum(error_bit_num2_vector)/sum(total_bit_num2_vector);
	ber3_vector(snr_idx) = sum(error_bit_num3_vector)/sum(total_bit_num3_vector);
    ber4_vector(snr_idx) = sum(error_bit_num4_vector)/sum(total_bit_num4_vector);
    error_block_num1_cell{snr_idx} = error_block_num1_vector;
    error_block_num2_cell{snr_idx} = error_block_num2_vector;
	error_block_num3_cell{snr_idx} = error_block_num3_vector;
    error_block_num4_cell{snr_idx} = error_block_num4_vector;
    bler1_vector(snr_idx) = sum(error_block_num1_vector)/TTI_NUM;
    bler2_vector(snr_idx) = sum(error_block_num2_vector)/TTI_NUM;
	bler3_vector(snr_idx) = sum(error_block_num3_vector)/TTI_NUM;
    bler4_vector(snr_idx) = sum(error_block_num4_vector)/TTI_NUM;
end
%% Plot figure
% save(OUTPUT_DATA_PATH);
% plotFigure;
% saveFigure;
save([num2str(TTI_START-1),'.mat']);
profile viewer