function synchronize(signal)
    for i = 1:size(signal)
        if signal[i:i+4] = [1 1 1 1]
            signal = signal[:i]
        end
    end
