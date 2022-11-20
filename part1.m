%%_3270_3271
% Part 1
fsignal = bandpass(EEG_RAWdata,[5 20],256);

t1  = fsignal(:,1)./fs;
u_1 = 1:2:10;
v_1 = 2:2:10;
figure(1)
for a = 1:5
    subplot(5,2,u_1(a))
    plot(EEG_RAWdata(:,a+11),t1);
    str = sprintf('Plot of raw.signal channel %d',a+11);
    title(str)
    ylabel("voltage");
    xlabel("time");
    
    subplot(5,2,v_1(a))
    plot(fsignal(:,a+11),t1);
    str = sprintf('Plot of filt.signal channel %d',a+11);
    title(str)
    ylabel("voltage");
    xlabel("time");
   
end    

raw.fftSignal = fft(EEG_RAWdata);
raw.fftSignal = fftshift(raw.fftSignal);
filt.fftSignal = fft(fsignal);
filt.fftSignal = fftshift(filt.fftSignal);
f = fs/2*linspace(-1,1,fs);

u_1 = 1:2:10;
v_1 = 2:2:10;
figure(2)
for a = 1:5
    subplot(5,2,u_1(a))
    plot(raw.fftSignal(:,a+11),t1);
    str = sprintf('Plot of raw.signal magnitude FFT channel %d',a+11);
    title(str)
    xlabel('Frequency (Hz)');
    ylabel('magnitude');
    
    subplot(5,2,v_1(a))
    plot(filt.fftSignal(:,a+11),t1);
    str = sprintf('Plot of filt.signal magnitude FFT channel %d',a+11);
    title(str)
    xlabel('Frequency (Hz)');
    ylabel('magnitude');
   
end 

%% Part 2
bands = [1 80;81 160;161 240];
t_2=linspace(1,768,768);
u_1 = 1:2:10;
v_1 = 2:2:10;
EEG.sum_1 =(zeros(768,30));
EEG.sum_2 =(zeros(768,30));
EEG.sum_3 =(zeros(768,30));
for a =1:3
    for j = bands(a,1):bands(a,2)
        EEG_seg = squeeze(EEG_segmented(j,:,:));
        subplot(3,1,a)
        EEG.("sum"+num2str(a))= EEG.("sum"+num2str(a)) + EEG_seg;
        plot(EEG_seg,t_2,'Color','blue')
        str = sprintf('Plot of trails of %d to %d and average of those trails',bands(a,1),bands(a,2));
        title(str)
        xlabel('Time');
        ylabel('Magnitude');
        hold on; 
    end
    plot(EEG.("sum"+num2str(a)),t_2,'Color','red')
    legend({'All trails','Average of trails'},'TextColor','blue','FontSize',10)
    legend('boxoff')
    hold off;
end

