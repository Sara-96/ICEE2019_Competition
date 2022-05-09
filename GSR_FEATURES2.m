function features = GSR_FEATURES2(input_signal,fs)
 
 
[pks,locs]=findpeaks(input_signal,'MinPeakDistance',25);


if mod(length(locs),2)==1
    locs=locs(1:end-1);
end

if length(locs)==0
    z=0;
else
 
for i = 1 : 2 : length(locs)
    
    z(ceil(i/2))=locs(i+1) - locs(i) ;
    
end
end

ptot = bandpower(input_signal,fs,[0 2.4]);
q1 = lowpass(input_signal,0.2,fs);
q2=lowpass(input_signal,0.08,256);

feat1=ptot;
feat2=mean(q1);
feat3=max(q2);

features=[feat1,feat2,feat3];

end
