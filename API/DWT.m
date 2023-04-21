function [dwt_res, dwt_heart] = DWT(unwrapped_phase,t,f,Fs,fig)
%%
if nargin < 5
    fig = 0;
else
    fig =1;
end
%%
dwt_res = restructure_dwt(unwrapped_phase,[0.1 0.5],'coif3',Fs);
dwt_heart = restructure_dwt(unwrapped_phase,[1 2],'coif4',Fs);

if fig ==1
    figure()                                               % Time domain of DWT respiration
    plot(t, dwt_res/max(abs(dwt_res))) 
    xlabel("Time (s)")
    ylabel("Normalized Amplitude")
    xlim([0 t(end)])
    title('Respiration Signal by DWT')

    figure()                                                % Frequency domain of DWT respiration
    dwt_res_fft = abs(fft(dwt_res))/max(abs(fft(dwt_res)));
    plot(f, dwt_res_fft)  
    xlabel("Frequency (Hz)")
    ylabel("Normalized Amplitude")
    xlim([0 1])
    ylim([0 1.3])
    title('Respiration Signal by DWT')
    % 
    figure()                                              % Time domain of DWT heart
    plot(t, dwt_heart/max(abs(dwt_heart))) 
    xlabel("Time (s)")
    ylabel("Normalized Amplitude")
    xlim([0  t(end)])
    title('Heart  Signal by DWT')
    
    figure()                                                % Frequency domain of DWT heart
    dwt_heart_fft = abs(fft(dwt_heart))/max(abs(fft(dwt_heart)));
    plot(f, dwt_heart_fft)  
    xlabel("Frequency (Hz)")
    ylabel("Normalized Amplitude")
    xlim([0 2.3])
    ylim([0 1.3])
    title('Heart Signal by DWT')
end

end