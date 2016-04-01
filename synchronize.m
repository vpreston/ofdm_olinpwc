function process_signal(y,data)
    hold on
    plot(real(y),'g-')
    training_start = 64*2 + 1;
    data_start = training_start + 80;
    signal = correct_cfo_schmidl_cox(y(50:end));
    plot(real(signal),'r-')
    h = channel_estimate(signal(training_start:data_start),data);
    data = signal(data_start:end);
    f_data = fft(data);
    hdata = repmat(h,[10 1]);
    corrected_data = f_data.*hdata(1:length(f_data));
    plot(real(corrected_data),'b-')
end



