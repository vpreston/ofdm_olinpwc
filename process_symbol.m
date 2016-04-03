function sym = process_symbol(symbol,h)
    symbol = symbol(17:end);
    disp(length(h))
    disp(length(symbol))
    data = fft(symbol);
    sym = data./h;
end
