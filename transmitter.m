% This code creates a transmission signal that can be sent with an ESRP
% software defined radio unit. 

% This code creates a random signal vector using the helper function create_vector, performs an IFFT, identifies a
% cyclic prefix, then appends the prefix to the front of the transformed
% random signal vector.


% establish the header which will be in the time domain
header = create_header;

% make sure to save the signals for use by the receiver
known_signal = [header];
known = [];

% create the known data, 20 symbols
for j = 1:20
    data  = create_vector(64);
    signal = ifft(data)*64;
    cyclic_prefix = signal(end-15:end);
    known_signal = [known_signal;cyclic_prefix;signal];
    known = [known;cyclic_prefix;data];
end

final_signal = [known_signal];

% add the symbol payload of between 10-20 symbols
for i = 1:15
    random_data = create_vector(64);
    random_signal = ifft(random_data)*64;
    random_cp = random_signal(end-15:end);
    true_data = [random_cp;random_signal];
    final_signal = [final_signal;true_data];
end

% transmit the information through the USRPs by creating file it can parse,
% in this case a .dat file
save('transmitter.dat', 'final_signal')
