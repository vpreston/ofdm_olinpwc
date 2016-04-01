function sym = process_symbol(symbol,h)
    symbol = symbol(16:end);
    data = fft(symbol);
    sym = data/h;
end
