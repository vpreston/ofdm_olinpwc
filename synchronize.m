function process_signal(y)
    load('known_symbols.mat')
    signal = correct_cfo_schmidl_cox(y)
    h = channel_estimate(signal(training_start:data_start),leading_signal)
    data = signal(data_start:end)
    f_data = fft(data)
    corrected_data = f_data*h
end



