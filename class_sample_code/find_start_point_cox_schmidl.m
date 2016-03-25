function d = find_start_point_cox_scmidl(y, max_search_window)
%% returns the best start point of an OFDM frame, assuming 2 identical 
%% training sequences of length 64, which are repeated

metrics = zeros(64,1); % this is the vector of metrics for each search lag
% compute metrics for different lags
for d = 1:max_search_window
    metrics(d) = abs(sum(y(d:d+64-1).*conj(y(d+64:d+64+64-1))))^2/(sum(abs(y(d+64:d+64+64-1)).^2))^2;
end
% find the strongest metric, the index of this is the best lag
[mm,d] = max(metrics);

