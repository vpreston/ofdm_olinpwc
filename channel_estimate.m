function h = channel_estimate(signal,known)

    signal = signal(17:end);
    known = known(17:end);
    input = fft(signal);
    h = input./known;
end