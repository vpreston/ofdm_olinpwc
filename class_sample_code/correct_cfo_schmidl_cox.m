
% Synchronizes start of frame, assuming a coarse detection base (e.g.
% on increase in received signal power is detected).
% It then applies the Cox-Schmidl algorithm to correct for carrier
% frequency offset to the remainder of the packet
%
% Assumes that y is a vector containing the received packet
% two repeated training signals are assumed to be present in the beginning
% of y. So if you used 3 repeated training signals, you need to discard 
% the first ~ 64 samples after you detect an energy increase signifying 
% start of a packet


% find start index using the cox_scmidl algorithm to detect start of symbol 
% here we assume that we are within 20 samples of the actual start point
function y_corrected = correct_cfo_schmidl_cox(y)
start_idx = find_start_point_cox_schmidl(y, 20);

% this is the packet
y_frame = y(start_idx:end);

% next we are going to find the average CFO
avg_freq_error = 0;
for k = 1:64
    avg_freq_error = avg_freq_error + angle(y_frame(k+64)/y_frame(k))/64;
end
avg_freq_error = avg_freq_error/64;

% correct the frequency offset using estimated CFO
y_corrected = y_frame.*(exp(-1i*avg_freq_error*[1:length(y_frame)]'));
end

