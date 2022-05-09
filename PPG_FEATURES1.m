function ppg_features = PPG_FEATURES1(PPG_sig,fs)

% PPG_sig in PPG signal without PPG_Base!
% fs is Sampling frequency

%% Time domain Features
ppg_features_time(1) = median(PPG_sig);
ppg_features_time(2) = min(PPG_sig);
ppg_features_time(3) = max(PPG_sig);


%% First-order difference Features
PPG_sig_diff1 = diff(PPG_sig,1);

ppg_features_time(4) = median(PPG_sig_diff1);
ppg_features_time(5) = std(PPG_sig_diff1);
ppg_features_time(6) = max(PPG_sig_diff1);
ppg_features_time(7) = max(PPG_sig_diff1)/min(PPG_sig_diff1);
ppg_features_time(8) = min(PPG_sig_diff1)/max(PPG_sig_diff1);

%% Second-order difference Features
PPG_sig_diff2 = diff(PPG_sig,2);

ppg_features_time(9) = std(PPG_sig_diff2);
ppg_features_time(10) = max(PPG_sig_diff2);
ppg_features_time(11) = min(PPG_sig_diff2)/max(PPG_sig_diff2);
%% Frequency domain Features

[PPG_SIG,f] =pwelch(PPG_sig,fs/2,fs/8,fs,fs); % window = fs/2 ,nover = fs/8, nfft = fs, Fs = fs

ppg_feature_freq(12) = mean(PPG_SIG);
ppg_feature_freq(13) = median(PPG_SIG);
ppg_feature_freq(14) = std(PPG_SIG);
ppg_feature_freq(15) = min(PPG_SIG);
ppg_feature_freq(16) = max(PPG_SIG);
ppg_feature_freq(17) = range(PPG_SIG);

%% Concatanating time & Frequency Features
ppg_features = [ppg_features_time,ppg_feature_freq];
