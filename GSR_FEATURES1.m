function gsr_features = GSR_FEATURES1(GSR_sig,fs)

% GSR_sig is signal of GSR 
% fs is frequency samplingfunction gsr_features = GSR_FEATURES(GSR_sig,range,fs)

%% Time domain Features
gsr_features_time(1) = mean(GSR_sig);
gsr_features_time(2) = median(GSR_sig);
gsr_features_time(3) = std(GSR_sig);
gsr_features_time(4) = min(GSR_sig);
gsr_features_time(5) = max(GSR_sig);
gsr_features_time(6) = max(GSR_sig)/min(GSR_sig);
gsr_features_time(7) = skewness(GSR_sig);

q=ar(GSR_sig,10);
gsr_features_time(8:16) = q.A([2,3,4,5,6,7,8,9,10]);



%% First-order difference Features
GSR_sig_diff1 = diff(GSR_sig,1);


gsr_features_time(17) = mean(GSR_sig_diff1);
gsr_features_time(18) = median(GSR_sig_diff1);
gsr_features_time(19) = std(GSR_sig_diff1);
gsr_features_time(20) = max(GSR_sig_diff1);
gsr_features_time(21) = max(GSR_sig_diff1)/min(GSR_sig_diff1);
gsr_features_time(22) = mean(abs(GSR_sig_diff1));
gsr_features_time(23) = kurtosis(GSR_sig_diff1);

q=ar(GSR_sig_diff1,10);
gsr_features_time(24:29) = q.A([2 3 4 7 8 9]);



%% Second-order difference Features
GSR_sig_diff2 = diff(GSR_sig,2);


gsr_features_time(30) = min(GSR_sig_diff2);
gsr_features_time(31) = max(GSR_sig_diff2);
gsr_features_time(32) = max(GSR_sig_diff2)/min(GSR_sig_diff2);
gsr_features_time(33) = min(GSR_sig_diff2)/max(GSR_sig_diff2);
gsr_features_time(34) = mean(abs(GSR_sig_diff2));

q=ar(GSR_sig_diff2,10);
gsr_features_time(35:42) = q.A([2 4 5 6 7 8 9 10]);




%% Frequency domain Features

[pxx,f] =pwelch(GSR_sig,fs/2,fs/8,fs,fs); % window = fs/2 ,nover = fs/8, nfft = fs, Fs = fs
index_f = find((f>=0)&(f<=15)); % finding 0-15 Hz 
GSR_SIG = pxx(index_f);

gsr_feature_freq(1) = mean(GSR_SIG);
gsr_feature_freq(2) = median(GSR_SIG);
gsr_feature_freq(3) = std(GSR_SIG);
gsr_feature_freq(4) = max(GSR_SIG);
gsr_feature_freq(5) = range(GSR_SIG);

%% Concatanating time & Frequency Features
gsr_features = [gsr_features_time,gsr_feature_freq];

