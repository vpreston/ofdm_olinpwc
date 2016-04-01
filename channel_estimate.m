function h = channel_estimate(signal,known)
    signal = signal(17:end-1);
    input = fft(signal);
    h = input./known;
end