function h = channel_estimate(signal,known)
    signal = signal(17:end);
    disp(length(signal))
    input = fft(signal);
    h = input./known;
end