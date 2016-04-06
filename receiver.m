function receiver(y,known_signal)
    training_start = 64*2 + 1;
    data_start = training_start  + 80*4;
    
    signal = correct_cfo_schmidl_cox(y(50:end));
    %plot(real(signal),'r-')
    known = known_signal;
    
    h1 = channel_estimate(signal(training_start:training_start+79),known(1:80));
    h2 = channel_estimate(signal(training_start+80:training_start+(80+79)),known(81:(81+79)));
    h3 = channel_estimate(signal(training_start+(80+80):training_start+(80+80+79)),known((81+79+1):(81+79+1+79)));
    
    hs = cat(2,h1,h2,h3);
%     size(hs)
    
    h = mean(hs,2);
   % plot(abs(h),'r-')
    symbols = signal(data_start:end);
    
   %symbol_table = reshape(symbols(1:(15*80)),[80,15])
   
   corrected_data = process_symbol(symbols(1:80),h);
%    corrected_data = process_symbol(signal(training_start: training_start+79),h)
    
   plot(real(corrected_data),'b-')
end



