function receiver(y,known_signal)
    %create important indices
    training_start = 64*2 + 1;
    data_start = training_start  + 80*1;
    h = [];
    
    %find the start of the data and do a frequency correction
    signal = correct_cfo_schmidl_cox(y(50:end));
    known = known_signal;
    
    %perform the channel estimation
    for i=1:20
       h = [h,channel_estimate(signal(training_start+80*(i-1):training_start+79+80*(i-1)),known(1+80*(i-1):80+80*(i-1)))];
    end
    
    h = mean(h,2);

    %process the symbols
    symbols = signal(data_start:end);
   corrected_data = process_symbol(symbols(1:80),h);
    
   %plot everything
   hold on
   plot(real(corrected_data),'r-')
   plot(real(known(81+16:(81+79))),'b-')
   legend('Recovered Signal','Transmitted Signal')
end



