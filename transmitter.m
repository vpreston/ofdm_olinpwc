% This code creates a transmission signal that can be sent with an ESRP
% software defined radio unit. 

% This code creates a random signal vector using the helper function create_vector, performs an IFFT, identifies a
% cyclic prefix, then appends the prefix to the front of the transformed
% random signal vector.


% establish your data vector by placing the heading in the front, then
% simply adding data
header = create_header;
% data = create_vector(64);%this is in frequency
appended_signal = [header];

for i=1:3
   data = create_vector(64);
   signal = ifft(data)*64;
   cyclic_prefix = signal(end-15:end);
   appended_signal = [appended_signal; cyclic_prefix; signal];
end

% take the IFFT
% signal = ifft(data)*64;%put it in time

% append the cyclic prefix
% cyclic_prefix = signal(end-15:end);
% appended_signal = [header;cyclic_prefix;signal];

final_signal = [appended_signal];

% add the symbol payload of about 10-20 symbols (200 - 400 bits)
for i = 1:15
    random_data = create_vector(64);%create data in frequency
    random_signal = ifft(random_data)*64;
    random_cp = random_signal(end-15:end);
    true_data = [random_cp;random_signal];
    final_signal = [final_signal;true_data];
end

% transmit the information through the ESRPs by creating file it can parse,
% in this case a .dat file
save('transmitter.dat', 'final_signal')
