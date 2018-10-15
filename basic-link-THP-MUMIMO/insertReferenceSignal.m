function [grid_with_pilot_cell] = insertReferenceSignal(tti_idx,grid_cell,signal_power)
%insertReferenceSignal - Insert the reference signal into the resource block
% 
% Syntax:  [grid_with_pilot_cell] = insertReferenceSignal(tti_idx,grid_cell,signal_power)

% Input Arguments:
%    tti_idx - tti idx
%    grid_cell - grid need to insert reference signal
%    signal_power - Power for pilot 
%
% Output Arguments:
%    grid_with_pilot_cell - Resource grid with pilot

%----------------------------- BEGIN CODE ---------------------------------
loadConfig;
slot_idx = [(mod(tti_idx-1,SUBFRAME_NUM_PER_FRAME))*2;(mod(tti_idx-1,SUBFRAME_NUM_PER_FRAME))*2+1];
r1 = generateReferenceSignal(slot_idx(1),0);
r2 = generateReferenceSignal(slot_idx(1),1);
r3 = generateReferenceSignal(slot_idx(1),4);
r4 = generateReferenceSignal(slot_idx(2),0);
r5 = generateReferenceSignal(slot_idx(2),1);
r6 = generateReferenceSignal(slot_idx(2),4);
reference_signal = sqrt(signal_power)*[r1;r2;r3;r4;r5;r6];
port_cell = {0;1;2;3};
grid_with_pilot_cell = cellfun(@(x,y) insertReferenceSignalFor4Port(x,tti_idx,...
    reference_signal,y),port_cell,grid_cell,'UniformOutput',false);
end
%----------------------------- END OF CODE --------------------------------
