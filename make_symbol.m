function symbol= make_symbol()
    pilot = [1 1 1 1];
    sym = round(rand(1,12));
    sym(sym<.5)= -1;
    symbol = [pilot sym]
end


    