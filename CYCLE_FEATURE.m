function [Mean_Size_peak, Mean_cycle, Max_cycle, Min_cycle] = CYCLE_FEATURE(X)
%[r,c] = size(X);
[peak,locs] = findpeaks(X,'MinPeakProminence',0.002);
if (size(peak,2)<3)
    [peak,locs] = findpeaks(X,'MinPeakProminence',0.0002);
end
Mean_Size_peak = mean(peak);
cycle = zeros(1,size(peak,2)-1);
for k=1:size(peak,2)-1
    cycle(k) = locs(k+1) - locs(k);
end
Mean_cycle = mean(cycle);
Max_cycle = max(cycle);
Min_cycle = min(cycle);

% cycle_features = [Mean_Size_peak, Mean_cycle, Max_cycle, Min_cycle];

end
    
        
            

