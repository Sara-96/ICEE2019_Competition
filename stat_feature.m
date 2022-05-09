function [out_median,out_pow] = stat_feature(x,win,nover)

L = length(win);
M = length(x);
N = L-nover;

sig_norm = x(1:4*256);

for counter = 1:floor(M/N)-L
    sig = x((counter-1)*N+1:(counter-1)*N+L);
%     out_skewness(counter) = skewness(sig)/skewness(sig_norm);
%     out_kurtosis(counter) = kurtosis(sig)/kurtosis(sig_norm);
%     out_var(counter) = var(sig)/var(sig_norm);
%     out_mean(counter) = mean(sig)/mean(sig_norm);
    out_median(counter) = median(sig)/median(sig_norm);
    out_pow(counter) = dot(sig,sig)/dot(sig_norm,sig_norm);
end
% out_spline = polyfit(1:length(x),x,5);