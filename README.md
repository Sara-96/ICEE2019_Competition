# ICEE2019_Competition

a competition that was held in conjunction with the 27th Iranian Conference on Electrical Engineering (ICEE 2019). In this competition, the goal was to design a system for classifying mental arousal at five levels by using skin electrical conductivity signal (GSR), PhotoPlethysmography measurements (PPG), abdominal respiration (AR), and thorax respiration (TR). We did the following: 
1) Preprocessing and normalizing signals to reduce dependency on each person. 
2) 2) Extracting the stressrelated features of the signals (including frequency, temporal and statistical features). 
3) 3) Normalizing extracted features to reduce
their dependency on individuals. 
4) Selecting features to increase the performance of the models. we used the Least Absolute Shrinkage and Selection Operator (LASSO) which is a statistical approach, and then used NSGA-II, which is an Evolutionary Algorithm. 
5) Training and testing different models of machine learning by LOSO (Leave One Subject Out).
