function [breathe_EMD, heartbeat_EMD] = EMD(unwrapped_phase,t,f,Fs,fig)
%%
if nargin < 5
    fig = 0;
else
    fig =1;
end
%%
denoise = butterworth_high_pass_filter(unwrapped_phase,4,0.1,Fs);
denoise = butterworth_low_pass_filter(denoise,4,3,Fs);
IMF = emd1(denoise,'MAXITERATIONS',100);
[breathe_EMD,heartbeat_EMD] = plot_emd(denoise,IMF,1/Fs);

if fig == 1
    figure()                                            % Time domain of EMD respiration
    plot(t, breathe_EMD/max(abs(breathe_EMD))) 
    xlabel("Time (s)")
    ylabel("Normalized Amplitude")
    xlim([0  t(end)])
    title('Respiration Signal by EMD')

    figure()                                             % Frequency domain of EMD respiration
    breathe_EMD_fft = abs(fft(breathe_EMD))/max(abs(fft(breathe_EMD)));
    plot(f, breathe_EMD_fft)  
    xlabel("Frequency (Hz)")
    ylabel("Normalized Amplitude")
    xlim([0 1])
    ylim([0 1.3])
    title('Respiration Signal  by EMD')

    figure()                                          % Time domain of EMD heart
    plot(t, heartbeat_EMD/max(abs(heartbeat_EMD))) 
    xlabel("Time (s)")
    ylabel("Normalized Amplitude")
    xlim([0  t(end)])
    title('Heart Signal  by EMD')

    figure()                                            % Frequency domain of EMD heart
    heartbeat_EMD_fft = abs(fft(heartbeat_EMD))/max(abs(fft(heartbeat_EMD)));
    plot(f, heartbeat_EMD_fft)  
    xlabel("Frequency (Hz)")
    ylabel("Normalized Amplitude")
    xlim([0 2.3])
    ylim([0 1.3])
    title('Heart Signal  by EMD')
end

end