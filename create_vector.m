function create_vector()
    header = round(rand(1,64))
    header(header<.5)= -1
    header = repmat(header, [1 3])
end

function make_symbol()
    pilot = [1 1 1 1];
    sym = round(rand(1,12));
    sym(sym<.5)= -1;
end


    
