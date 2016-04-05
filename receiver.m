function receiver(y,data)
   
    %plot(real(y),'g-')

    training_start = 64*2 + 1;
    data_start = training_start + 80;
    
    signal = correct_cfo_schmidl_cox(y(50:end));
        
    h = channel_estimate(signal(training_start:data_start-1),data);
    %plot(abs(h),'r-')
    symbols = signal(data_start:end);
    
    corrected_data = process_symbol(symbols(1:80),h)
    %corrected_data = process_symbol(signal(training_start: training_start+79),h)
   plot(real(corrected_data),'b-')
   hold off
end



