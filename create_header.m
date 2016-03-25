function res = create_header()
    header = 2*round(rand(64,1)) - 1; 
    header = repmat(header, [3 1]);
    res = header;
end
