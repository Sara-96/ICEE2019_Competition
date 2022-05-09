function [ ppg_features ] = PPG_FEATURES2(ppg_raw_segment,ppg_base_raw_segment)
debug = 0;
freq = 256;
[~,ppg_systolic_locs] = findpeaks(ppg_raw_segment,'MinPeakDistance',600/(1000/freq),'WidthReference','halfheight');
[~,ppg_minimum_locs] = findpeaks(-1*ppg_raw_segment,'MinPeakDistance',600/(1000/freq),'WidthReference','halfheight');
if(debug==1)
    figure;plot(ppg_raw_segment)
    hold on
    scatter(ppg_systolic_locs,ppg_raw_segment(ppg_systolic_locs));
    scatter(ppg_minimum_locs,ppg_raw_segment(ppg_minimum_locs));
end
windows_features = [];
for w=round((1/3)*size(ppg_minimum_locs,2)):1:round((2/3)*size(ppg_minimum_locs,2))
    ppg_window = ppg_raw_segment(ppg_minimum_locs(w):ppg_minimum_locs(w+1));
    ppg_base_window = ppg_base_raw_segment(ppg_minimum_locs(w):ppg_minimum_locs(w+1));
    if(debug==1)
        figure;
        subplot(2,1,1)
        plot(ppg_window)
        subplot(2,1,2)
        plot(ppg_base_window)
%         pause
    end
    % Extract mNPV Feature
    ppg_window_mean = mean(ppg_base_window);
    ppg_window_std = std(ppg_window);
    ppg_window_dc = mean(ppg_base_window);
          % Window Normalization
    ppg_window = ppg_window - mean(ppg_window);
    ppg_window = ppg_window ./ std(ppg_window);
    ppg_window_ac = max(ppg_window) - min(ppg_window);
    mNPV = ppg_window_ac ./(ppg_window_ac + ppg_window_dc);
    if(debug==1)
    figure;
    suptitle('Normalized')
    subplot(2,1,1)
    plot(ppg_window)
    subplot(2,1,2)
    plot(ppg_base_window)
    pause
    end
    % Extract Heart Rate
    % Extract other feautres
    % Divide PPG window into two windows
    sysPeakLocation = find(ppg_window==max(ppg_window));
    window_part1 = ppg_window(1:sysPeakLocation);
    window_part2 = ppg_window(sysPeakLocation:end);
    window_part1_diff = diff(movmean(window_part1,10));
    window_part1_maxSlope_loc = find(window_part1_diff==max(window_part1_diff));
    maxSlope = window_part1_diff(window_part1_maxSlope_loc);
    windows_features = [windows_features;ppg_window_mean,ppg_window_std,mNPV,maxSlope];
end
ppg_features = [median(windows_features)];
end

