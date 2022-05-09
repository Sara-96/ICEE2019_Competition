function AllFeature=ARTR_FEATURES(AR,TR)
 
Fs = 256;
c = length(AR);
f = Fs*(0:(c/2))/c;
TRsumAR = AR+TR;

mAR=mean(AR);
mTR=mean(TR);
mTRsumAR=mean(TRsumAR);
stdAR=std(AR,1);
stdTR=std(TR,1);
stdTRsumAR=std(TRsumAR,1);
[maxX1,IX1] = max(AR);
[maxX3,IX3] = max(AR+TR);

[Mean_Size_peak1, Mean_cycle1, Max_cycle1, Min_cycle1] = CYCLE_FEATURE(AR);
[Mean_Size_peak2, Mean_cycle2, Max_cycle2, Min_cycle2]  = CYCLE_FEATURE(TR);
[Mean_Size_peak3, Mean_cycle3, Max_cycle3, Min_cycle3] = CYCLE_FEATURE(TRsumAR);
cycle_AR = [Mean_Size_peak1, Min_cycle1] ;
cycle_TR = [Mean_cycle2, Min_cycle2] ;
cycle_ARsumTR = [Mean_Size_peak3, Max_cycle3];

% very lowband frequency
very_lowband_AR = bandpower(AR,Fs,[0.01 0.05]);
% lowband frequency
lowband_AR = bandpower(AR,Fs,[0.05 0.15]);
% highband frequency
highband_AR = bandpower(AR,Fs,[0.15 0.5]); 
% lowband frequency
lowband_TR = bandpower(TR,Fs,[0.05 0.15]);
% highband frequency
highband_TR = bandpower(TR,Fs,[0.15 0.5]); 
% very lowband frequency
very_lowband_TRsumAR = bandpower(TRsumAR,Fs,[0.01 0.05]);
% highband frequency
highband_TRsumAR = bandpower(TRsumAR,Fs,[0.15 0.5]);
    
psd_features = [very_lowband_AR,lowband_AR,highband_AR,lowband_TR,highband_TR,very_lowband_TRsumAR,highband_TRsumAR];

% wavelet of AR
[c,l] = wavedec(AR,8,'db1');
approx = appcoef(c,l,'db1');
[cd_AR] = detcoef(c,l,8);
var_cd_AR = var(cd_AR);
skewness_cd_AR = skewness(cd_AR);
mean2_cd_AR = mean(cd_AR.^2);
var2_cd_AR = var(cd_AR.^2);
    
% wavelet of TR
[c,l] = wavedec(TR,8,'db1');
approx = appcoef(c,l,'db1');
[cd_TR] = detcoef(c,l,8);
mean_cd_TR = mean(cd_TR);
var_cd_TR = var(cd_TR);
mean2_cd_TR = mean(cd_TR.^2);
    
% wavelet of TRsumAR
[c,l] = wavedec(TRsumAR,8,'db1');
approx = appcoef(c,l,'db1');
[cd_TRsumAR] = detcoef(c,l,8);
mean_cd_TRsumAR = mean(cd_TRsumAR);
var_cd_TRsumAR = var(cd_TRsumAR);
mean2_cd_TRsumAR = mean(cd_TRsumAR.^2);
var2_cd_TRsumAR = var(cd_TRsumAR.^2);
skewness2_cd_TRsumAR = skewness(cd_TRsumAR.^2);
kurtosis2_cd_TRsumAR = kurtosis(cd_TRsumAR.^2);
    
wavelet_features = [var_cd_AR,skewness_cd_AR,mean2_cd_AR,var2_cd_AR, mean_cd_TR,var_cd_TR,mean2_cd_TR, mean_cd_TRsumAR,var_cd_TRsumAR,mean2_cd_TRsumAR,var2_cd_TRsumAR,skewness2_cd_TRsumAR,kurtosis2_cd_TRsumAR ];

% autoregressive feature
sum_AR = 0;
sum_TR = 0;
sum_TRsumAR = 0;
for j=1:length(AR)
    sum_AR = sum_AR + (AR(j))^2;
    sum_TR = sum_TR + (TR(j))^2;
    sum_TRsumAR = sum_TRsumAR + (TRsumAR(j))^2;
end
% autoregressive feature of AR
EI_AR  = sum_AR/length(AR);
FZX_AR = (EI_AR)^0.5;
m_AR        = ar(AR, 2);
A_AR(1:2,1) = getpvec(m_AR);
a1_AR  = A_AR(1,1);
a2_AR  = A_AR(2,1);
FAR_AR = (Fs/(2*pi))*atan(a1_AR/a2_AR);
STR_AR = (a1_AR^2 + a2_AR^2)^0.5; 
% autoregressive feature of TR
EI_TR  = sum_TR/length(TR);
FZX_TR = (EI_TR)^0.5;
m_TR        = ar(TR, 2);
A_TR(1:2,1) = getpvec(m_TR);
a1_TR  = A_TR(1,1);
a2_TR  = A_TR(2,1);
FAR_TR = (Fs/(2*pi))*atan(a1_TR/a2_TR);
STR_TR = (a1_TR^2 + a2_TR^2)^0.5;
    
% autoregressive feature of TRsumAR
EI_TRsumAR  = sum_TRsumAR/size(TRsumAR, 2);
FZX_TRsumAR = (EI_TRsumAR)^0.5;
m_TRsumAR        = ar(TRsumAR, 2);
A_TRsumAR(1:2,1) = getpvec(m_TRsumAR);
a1_TRsumAR  = A_TRsumAR(1,1);
a2_TRsumAR  = A_TRsumAR(2,1);
FAR_TRsumAR = (Fs/(2*pi))*atan(a1_TRsumAR/a2_TRsumAR);

autoregressive_features = [EI_AR, FZX_AR, FAR_AR, STR_AR, EI_TR, FZX_TR, FAR_TR, STR_TR, EI_TRsumAR, FZX_TRsumAR, FAR_TRsumAR];

% AR_10
m_AR10 = ar(AR, 10);
A_AR10(1:10,1) = getpvec(m_AR10);
m_TR10 = ar(TR, 10);
A_TR10(1:10,1) = getpvec(m_TR10);
m_SUM10 = ar(TRsumAR, 10);
A_SUM10(1:10,1) = getpvec(m_SUM10);
ARten = transpose(A_AR10);
TRten = transpose(A_TR10);
SUMten = transpose(A_SUM10);
ARtenFeature = [ARten(1:6), ARten(8:10), TRten(2:3), TRten(5:7), TRten(9:10), SUMten(1), SUMten(3:10)];


[r,c]   = size(AR);
TRsumAR = AR+TR;
Fs      = 256;
f       = Fs*(0:(c/2))/c;
window  = 30;
t       = 0:1/Fs:(c-1/Fs);

% amplitude for AR signal    
[Maxima_AR,MaxIdx_AR] = findpeaks(AR,'MinPeakProminence',0.0004);
if (size(Maxima_AR,2)<3)
     [Maxima_AR,MaxIdx_AR] = findpeaks(AR,'MinPeakProminence',0.0001);
end
DataInv_AR = 1.01*max(AR) - AR;
[Minima_AR,MinIdx_AR] = findpeaks(DataInv_AR,'MinPeakProminence',0.0004);
%     MinIdx = islocalmax(DataInv(i,:));
if (size(Minima_AR,2)<3)
     [Minima_AR,MinIdx_AR] = findpeaks(DataInv_AR,'MinPeakProminence',0.0001);
end
Minima_AR = AR(MinIdx_AR);
n=min(length(Minima_AR),length(Maxima_AR));
for k=1:n
    amplitude_AR(k) =  Maxima_AR(k) - Minima_AR(k);
end
mean_amplitude_AR = mean(amplitude_AR);
var_amplitude_AR = var(amplitude_AR);
median_amplitude_AR = median(amplitude_AR);
    
% amplitude for TR signal
[Maxima_TR,MaxIdx_TR] = findpeaks(TR,'MinPeakProminence',0.0004);
if (size(Maxima_TR,2)<3)
     [Maxima_TR,MaxIdx_TR] = findpeaks(TR,'MinPeakProminence',0.0001);
end
DataInv_TR = 1.01*max(TR) - TR;
[Minima_TR,MinIdx_TR] = findpeaks(DataInv_TR,'MinPeakProminence',0.0004);
if (size(Minima_TR,2)<3)
     [Minima_TR,MinIdx_TR] = findpeaks(DataInv_TR,'MinPeakProminence',0.0001);
end
Minima_TR = TR(MinIdx_TR);
n=min(length(Minima_TR),length(Maxima_TR));
for k=1:n
    amplitude_TR(k) =  Maxima_TR(k) - Minima_TR(k);
end
mean_amplitude_TR = mean(amplitude_TR);
median_amplitude_TR = median(amplitude_TR);
    
% amplitude for TRsumAR signal
[Maxima_TRsumAR,MaxIdx_TRsumAR] = findpeaks(TRsumAR,'MinPeakProminence',0.0004);
if (size(Maxima_TRsumAR,2)<3)
     [Maxima_TRsumAR,MaxIdx_TRsumAR] = findpeaks(TRsumAR,'MinPeakProminence',0.0001);
end
DataInv_TRsumAR = 1.01*max(TRsumAR) - TRsumAR;
[Minima_TRsumAR,MinIdx_TRsumAR] = findpeaks(DataInv_TRsumAR,'MinPeakProminence',0.0004);
%     MinIdx = islocalmax(DataInv(i,:));
if (size(Minima_TRsumAR,2)<3)
     [Minima_TRsumAR,MinIdx_TRsumAR] = findpeaks(DataInv_TRsumAR,'MinPeakProminence',0.0001);
end
Minima_TRsumAR = TRsumAR(MinIdx_TRsumAR);
n=min(length(Minima_TRsumAR),length(Maxima_TRsumAR));
for k=1:n
    amplitude_TRsumAR(k) =  Maxima_TRsumAR(k) - Minima_TRsumAR(k);
end
mean_amplitude_TRsumAR = mean(amplitude_TRsumAR);

amplitude_features = [mean_amplitude_AR,mean_amplitude_TR,mean_amplitude_TRsumAR,var_amplitude_AR, median_amplitude_AR, median_amplitude_TR];

[r,c] = size(AR);
TRsumAR = AR+TR;
Fs = 256;
f = Fs*(0:(c/2))/c;
window = 30;
t=0:1/Fs:(c-1/Fs);

% width feature of AR
[Maxima_AR,MaxIdx_AR] = findpeaks(AR,'MinPeakProminence',0.0004);
if (size(Maxima_AR,2)<3)
     [Maxima_AR,MaxIdx_AR] = findpeaks(AR,'MinPeakProminence',0.0001);
end
DataInv_AR = 1.01*max(AR) - AR;
[Minima_AR,MinIdx_AR] = findpeaks(DataInv_AR,'MinPeakProminence',0.0004);
if (size(Minima_AR,2)<3)
     [Minima_AR,MinIdx_AR] = findpeaks(DataInv_AR,'MinPeakProminence',0.0001);
end
Minima_AR = AR(MinIdx_AR);
n=min(length(Minima_AR),length(Maxima_AR));
for k=1:n
    if MaxIdx_AR(1)>MinIdx_AR(1)
        widths_AR(k) = MaxIdx_AR(k) - MinIdx_AR(k);
    end
    if MaxIdx_AR(1)<MinIdx_AR(1)        
        widths_AR(k) = MinIdx_AR(k) - MaxIdx_AR(k);         
    end
end
num_min_AR = length(MinIdx_AR);
for j=1:(num_min_AR-1)
    width_trough_AR(j) = MinIdx_AR(j+1) - MinIdx_AR(j);
end
num_max_AR = length(MaxIdx_AR);
for j=1:(num_max_AR-1)
    width_peak_AR(j) = MaxIdx_AR(j+1) - MaxIdx_AR(j);
end
mean_peak_AR = mean(width_peak_AR/Fs);
median_peak_AR = median(width_peak_AR/Fs);
mean_trough_AR = mean(width_trough_AR/Fs);
median_trough_AR = median(width_trough_AR/Fs);
mean_width_AR = mean(widths_AR/Fs);    
    
    % width feature of TR
[Maxima_TR,MaxIdx_TR] = findpeaks(TR,'MinPeakProminence',0.0004);
if (size(Maxima_TR,2)<3)
     [Maxima_TR,MaxIdx_TR] = findpeaks(TR,'MinPeakProminence',0.0001);
end
DataInv_TR = 1.01*max(TR) - TR;
[Minima_TR,MinIdx_TR] = findpeaks(DataInv_TR,'MinPeakProminence',0.0004);
%     MinIdx = islocalmax(DataInv(i,:));
if (size(Minima_TR,2)<3)
     [Minima_TR,MinIdx_TR] = findpeaks(DataInv_TR,'MinPeakProminence',0.0001);
end
Minima_TR = TR(MinIdx_TR);
n=min(length(Minima_TR),length(Maxima_TR));
for k=1:n
    if MaxIdx_TR(1)>MinIdx_TR(1)
        widths_TR(k) = MaxIdx_TR(k) - MinIdx_TR(k);
    end
    if MaxIdx_TR(1)<MinIdx_TR(1)        
        widths_TR(k) = MinIdx_TR(k) - MaxIdx_TR(k);        
    end
end
num_min_TR = length(MinIdx_TR);
for j=1:(num_min_TR-1)
    width_trough_TR(j) = MinIdx_TR(j+1) - MinIdx_TR(j);
end
num_max_TR = length(MaxIdx_TR);
for j=1:(num_max_TR-1)
    width_peak_TR(j) = MaxIdx_TR(j+1) - MaxIdx_TR(j);
end
   
mean_width_TR = mean(widths_TR/Fs);
skewness_width_TR = skewness(widths_TR/Fs) ;
    
    % width feature of TRsumAR
[Maxima_TRsumAR,MaxIdx_TRsumAR] = findpeaks(TRsumAR,'MinPeakProminence',0.0004);
if (size(Maxima_TRsumAR,2)<3)
     [Maxima_TRsumAR,MaxIdx_TRsumAR] = findpeaks(TRsumAR,'MinPeakProminence',0.0001);
end
DataInv_TRsumAR = 1.01*max(TRsumAR) - TRsumAR;
[Minima_TRsumAR,MinIdx_TRsumAR] = findpeaks(DataInv_TRsumAR,'MinPeakProminence',0.0004);
%     MinIdx = islocalmax(DataInv(i,:));
if (size(Minima_TRsumAR,2)<3)
     [Minima_TRsumAR,MinIdx_TRsumAR] = findpeaks(DataInv_TRsumAR,'MinPeakProminence',0.0001);
end
Minima_TRsumAR = TRsumAR(MinIdx_TRsumAR);
n=min(length(Minima_TRsumAR),length(Maxima_TRsumAR));
for k=1:n
    if MaxIdx_TRsumAR(1)>MinIdx_TRsumAR(1)
        widths_TRsumAR(k) = MaxIdx_TRsumAR(k) - MinIdx_TRsumAR(k);
    end
    if MaxIdx_TRsumAR(1)<MinIdx_TRsumAR(1)        
        widths_TRsumAR(k) = MinIdx_TRsumAR(k) - MaxIdx_TRsumAR(k);        
    end
end
    %[pks,locs,widths,proms] = findpeaks(TRsumAR(i,:),'MinPeakProminence',0.002)
num_min_TRsumAR = length(MinIdx_TRsumAR);
for j=1:(num_min_TRsumAR-1)
    width_trough_TRsumAR(j) = MinIdx_TRsumAR(j+1) - MinIdx_TRsumAR(j);
end
num_max_TRsumAR = length(MaxIdx_TRsumAR);
for j=1:(num_max_TRsumAR-1)
    width_peak_TRsumAR(j) = MaxIdx_TRsumAR(j+1) - MaxIdx_TRsumAR(j);
end
mean_peak_TRsumAR = mean(width_peak_TRsumAR/Fs);
median_peak_TRsumAR = median(width_peak_TRsumAR/Fs);
median_trough_TRsumAR = median(width_trough_TRsumAR/Fs);  
var_width_TRsumAR = var(widths_TRsumAR/Fs);

width_features = [mean_peak_AR, mean_peak_TRsumAR, median_peak_AR, median_peak_TRsumAR, mean_trough_AR, median_trough_AR, median_trough_TRsumAR, mean_width_AR, mean_width_TR, var_width_TRsumAR, skewness_width_TR];

AllFeature = [mAR,mTR,mTRsumAR,stdAR,stdTR,stdTRsumAR,maxX1,IX1,maxX3,cycle_AR,cycle_TR,cycle_ARsumTR,psd_features,wavelet_features,autoregressive_features,ARtenFeature,amplitude_features,width_features];

end




