function PlotSignals(GSR,PPG,PPGBase,AR,TR,i,j)
fs=256; %%
window=30;
t=0:1/fs:(window-1/fs);
subplot(2,2,1); plot(t,GSR);title(['GSR signals for segment',num2str(j),'of Subject',num2str(i)]);xlabel('time (second)')
subplot(2,2,2); plot(t,PPG);title(['PPG signals segment',num2str(j),'of Subject',num2str(i)]);xlabel('time (second)')
subplot(2,2,3); plot(t,AR);title(['AR signals segment',num2str(j),'of Subject',num2str(i)]);xlabel('time (second)')
subplot(2,2,4); plot(t,TR);title(['TR signals segment',num2str(j),'of Subject',num2str(i)]);xlabel('time (second)')