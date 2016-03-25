function h = channel_estimate(signal,known)
    symbols = signal((64*3+16):end)
    y = fft(symbols)
    x = fft(known)
    h = y./x
end

function breaks = separate_parts(signal)
    indices = zeroes(4)
    signal_end = signal(64*3+16:);
    breaks = 1
end
    

