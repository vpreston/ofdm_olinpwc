function process_signal(y,data)
    hold on
    %plot(real(y),'g-')
    training_start = 64*2 + 1;
    data_start = training_start + 80;
    signal = correct_cfo_schmidl_cox(y(50:end));
    %plot(real(signal),'r-')
    h = channel_estimate(signal(training_start:data_start),data);
    data = signal(data_start:end);
   % data = reshape(data(1:15*80),15,[]);
    corrected_data = process_symbol(data(1:80),h)
    plot(real(corrected_data),'b-')
end



