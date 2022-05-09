function Features=ExtractFeatures(GSR,PPG,PPGBase,AR,TR,fs)

gsr_features = GSR_FEATURES1(GSR,fs); %GSR Features 1
ppg_features = PPG_FEATURES1(PPG,fs); %PPG Features 1
ppg_features1 = PPG_FEATURES2(PPG,PPGBase); %PPG Features 2
m=GSR_FEATURES2(GSR,fs) ;    %GSR Features 2
m2=GSR_FEATURES3(GSR);          %GSR Features 3
so = ARTR_FEATURES(AR,TR) ;  %AR/TR Features


Features=[gsr_features,ppg_features,ppg_features1,m,so,m2];