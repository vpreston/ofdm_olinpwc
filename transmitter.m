% This code creates a transmission signal that can be sent with an ESRP
% software defined radio unit. 

% This code creates a random signal vector using the helper function create_vector, performs an IFFT, identifies a
% cyclic prefix, then appends the prefix to the front of the transformed
% random signal vector.


% establish your data vector by placing the heading in the front, then
% simply adding data
header = create_header;
data = create_vector(64);

% take the IFFT
signal = ifft(data);

% append the cyclic prefix
cyclic_prefix = signal(length(signal)-16:length(signal));
appended_signal = [header;cyclic_prefix;signal;];

% add the symbol payload of about 10-20 symbols (200 - 400 bits)
random_data = create_vector(240);
final_signal = [appended_signal; random_data];

% transmit the information through the ESRPs by creating file it can parse,
% in this case a .dat file
save('transmitter.dat', 'final_signal')
