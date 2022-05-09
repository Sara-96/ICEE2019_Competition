%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%      ICBME    Competition               %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%    HMIL Sharif Team Main File           %%%%%%%%%%%%%%%%%%
% Total files need: 4 function for each signal feature extraction %
% Performace is measured by performace_measure function with LOSO mehod %
% Some commands needs MATLAB R2018 version ... %

clc
close all
clear all

%% Data Loading & Feature Extraction
%--------------------- Enter path of downloaded data------------------------
datapath='F:\ICEE2019_Competition\';
plotsignal=true;%false; %false
%--------------------------------------------------------------------------
fs=256; %frequency of sampling
label=[];
number_of_subjects=30;
FeaturesAllSubject=[];
for i=1:number_of_subjects
    all_features_subjecti=[];
    load(['SubjectID',num2str(i,'%02d'),'']);
    fprintf('load the data of SubjectID=%d \n',i);
    
    % This signals are measured for Signal Normalization
    PPG_mean=mean(mean(data.PPG));
    PPGBase_mean=mean(mean(data.PPGBase));
    GSR_mean=mean(mean(data.GSR));   %%has been used
    AR_mean=mean(mean(data.AR));    %%has been used
    TR_mean=mean(mean(data.TR));    %% has been used
    
    for j = 1 : size(data.GSR,1)
        out=ExtractFeatures((data.GSR(j,:)-GSR_mean),(data.PPG(j,:)-PPG_mean),(data.PPGBase(j,:)-PPGBase_mean),(data.AR(j,:)-AR_mean),(data.TR(j,:)-TR_mean),fs);
        all_features_subjecti=[all_features_subjecti;out];
    end
    SIG = FEATURE_NORMALIZATION(all_features_subjecti); %This command will normalize features for each subject
    FeaturesAllSubject=[FeaturesAllSubject;SIG];
    q=i*ones(size(data.Label,2),1);
    m=[data.Label',q];
    label=[label;m];
end
FeaturesAllSubject=[FeaturesAllSubject,label];   % Finally Feature Matrix Buildup with FeaturesAllSubject Name
save('FeaturesAllSubject','FeaturesAllSubject')

%% Classification
clear
clc
close all

% loading Feature Matrix
load('FeaturesAllSubject')

%% Lasso for feature redcution
% This section may need time
L = lasso(FeaturesAllSubject(:,1:end-2),FeaturesAllSubject(:,end-1));   % Performing Lasso on datas
[sorted_L,index] = sort(abs(L(:,1)),'descend'); % Sorting features metrics
Features_ID = index(1:140);  % Selecting 140 best features out of All features

FeaturesAllSubject = [FeaturesAllSubject(:,Features_ID),FeaturesAllSubject(:,end-1:end)]; % Bulding up newfeature matrix with subjectsIDs & labels
%% Classification
% Indicating Subjects IDs
SubjectID=unique(FeaturesAllSubject(:,end));

LabeltestLOO=[];
classification_outputTest=[];

for i=SubjectID'
    testindex=find(FeaturesAllSubject(:,end)==i);
    testdata=FeaturesAllSubject(testindex,1:end-2);
    Labeltest=FeaturesAllSubject(testindex,end-1);
    LabeltestLOO=[LabeltestLOO;Labeltest];
    
    trainindex=find(FeaturesAllSubject(:,end)~=i);
    traindata=FeaturesAllSubject(trainindex,1:end-2);
    Labeltrain=FeaturesAllSubject(trainindex,end-1);
    
    % classification
    Model = trainClassifier([traindata,Labeltrain]);  % our classifier generates model by receiving [train_data,Labeltrain] near eachother
    classification_outputTest = [classification_outputTest;Model.predictFcn(testdata)];
    fprintf('Labels of SubjectID%d Generated.\n',i);
end

%% Assessing
[acc, icc] = performance_measure(LabeltestLOO,classification_outputTest)
