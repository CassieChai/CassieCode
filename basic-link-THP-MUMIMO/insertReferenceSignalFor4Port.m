function [grid] = insertReferenceSignalFor4Port(port,tti_idx,reference_signal,grid)
%insertReferenceSignal - Insert the reference signal into the resource block
%
% Syntax:  [grid] = insertReferenceSignalFor4Port(port,slot_idx,reference_signal,grid)
%
% Input Arguments:
%    port - antenna port
%    tti_idx - tti No
%    reference_signal - reference signal
%    grid - grid need to insert reference signal
%
% Output Arguments:
%    grid - Resource grid with pilot

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
v_shift = mod(CELL_ID,6);
slot_idx = [(mod(tti_idx-1,SUBFRAME_NUM_PER_FRAME))*2;(mod(tti_idx-1,SUBFRAME_NUM_PER_FRAME))*2+1];

switch port
    % port0
    case 0
        % OFDM0
        v = 0;
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,1) = reference_signal(1,mm_vector);
        
        % OFDM4
        v = 3;
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,5) = reference_signal(3,mm_vector);
        
        % OFDM7
        v = 0;
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,8) = reference_signal(4,mm_vector);
        
        % OFDM11
        v = 3;
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,12) = reference_signal(6,mm_vector);
        
    % port1
    case 1
        % OFDM0
        v = 3;
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,1) = reference_signal(1,mm_vector);
        
        % OFDM4
        v = 0;
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,5) = reference_signal(3,mm_vector);
        
        % OFDM7
        v = 3;
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,8) = reference_signal(4,mm_vector);
        
        % OFDM11
        v = 0;
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,12) = reference_signal(6,mm_vector);
    % port2
    case 2
        % OFDM1
        v = 3*mod(slot_idx(1),2);
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,2) = reference_signal(2,mm_vector);
        
        % OFDM8
        v = 3*mod(slot_idx(2),2);
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,9) = reference_signal(5,mm_vector);
               
    % port3
    case 3
        % OFDM1
        v = 3 + 3*mod(slot_idx(1),2);
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,2) = reference_signal(2,mm_vector);
        
        % OFDM8
        v = 3 + 3*mod(slot_idx(2),2);
        m_vector = 0:2*RESOURCE_BLOCK_NUM-1;
        mm_vector = m_vector + MAX_RESOURCE_BLOCK_NUM - RESOURCE_BLOCK_NUM;
        k_vector = 6*m_vector + mod(v+v_shift,6) + 1;
        grid(k_vector,9) = reference_signal(5,mm_vector);
end
end
