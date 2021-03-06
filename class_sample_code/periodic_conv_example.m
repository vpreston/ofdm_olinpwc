% The purpose of this exercise is to illustrate the DFT property that 
% circular convolution in time becomes multiplication in the discretized frequency domain
% i.e the DFT space
 

% this next block creates a 15 sample long model impulse response
% with zero padding
h_tmp = [0.01 0.1 -0.04 0.02 -0.00001];
h_tmp = upsample(h_tmp, 3);
h = zeros(64,1);
h(1:15) = h_tmp;


% generate random =- 1 values to simulate data in the frequency domain
W = 2*round(rand(64,1)) - 1; 
% plot(W)

% take the ifft to geenerate time-domain samples
w = ifft(W);
plot(w)


% we are now going to try two different things. the first is the convolution of x with the impulse response of the channel

y_reg_conv = conv(w,h);

% create a new vector which will contain a portion of the periodically extended version of the desired transmit signal.
tilde_w = zeros(64+15,1);
tilde_w(1:15) = w(end-14:end);
tilde_w(16:end) = w;

y_periodic_ext_conv = conv(tilde_w, h);

% take the fft of h
H = fft(h);

% the desired behavior is for the IFFT of Y to be the product of the IFFT of W and the IFFT of H
Y_desired = W.*H;


% now, we shall check which of the time-domain y signals results in something closer to Y_desired
% this is the fft of the regular w convolved with the channel.
Y_reg_conv = fft(y_reg_conv(1:64));

% this is the fft of the signal that results from periodically extending a portion of w in the beginning
% and filtering that through the channel 
Y_periodic_ext_conv = fft(y_periodic_ext_conv(16:16+64-1));



% plot(real(Y_desired), 'r-s');
% hold on;
% plot(real(Y_reg_conv), 'b-o');
% plot(real(Y_periodic_ext_conv), 'm');
% % hold off
% legend('DFT of Desired', 'DFT of Regular Convolution', 'DFT of Periodically Extended Convolution');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Questions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Compare the three graphs

% It is pretty clear that the Periodically extended version more closely
% matches that of the desired data (almost perfectly, which is pretty
% cool). The Regular convolution has generally the right shape, but a
% shifted amplitude.

% 2. With respect to the periodic convolution -> multiplication of the DFT
% property, explain what you see.

% I'm not too positive on this one. My intuition is that there is a "shift"
% in aplitude taking place somewhere, but don't have a huge grasp.

% 3. Why was it only necessary to periodically extend w by 15 samples?
%    Hint: The impulse response h has length 15

% I imagine so that the peak of the impulse response is not oversampled...
%

% 4. The periodic extension of the end of a set of time domain samples 
%    in OFDM is called a cyclic-prefix, and is meant to simulate circular
%    convolution in real-world channels which perform regular convolution
%    The impulse responses can be safely approximated as being of finite 
%    duration. Why is this called the cyclic prefix?

% To capture the impulse cycle.

% 5. Divide out the channel effects from Y_periodic_ext_conv and 
%    Y_reg_conv (note that you have to use the complex numbers here)
%    Plot the real parts of both signals and compare

% sans_H_periodic = Y_periodic_ext_conv./H
% sans_H_reg = Y_reg_conv./H
% 
% 
% plot(real(sans_H_periodic))
% plot(real(sans_H_reg))
% legend('Periodic','Reg')
