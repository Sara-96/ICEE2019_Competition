function SIG = FEATURE_NORMALIZATION(SIG)
% This function is used for feature data normalization
for counter = 1:size(SIG,2)
    SIG(:,counter) = (SIG(:,counter) - mean(SIG(:,counter)))./(max(SIG(:,counter))- min(SIG(:,counter)));
end

