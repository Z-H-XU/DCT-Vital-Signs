function plot_t_f(signal,t,f)

figure()
plot(t,signal)                       %  Time domain of signal
xlabel('time(s)')
ylabel('Amplitude(V)')
xlim([0 30])
ylim([-1.5 1.5])

figure()                          %  Frequency domain of signal
dwt_heart_fft = abs(fft(signal))/max(abs(fft(signal)));
plot(f, dwt_heart_fft)  
xlabel("frequency(Hz)")
ylabel("Normalized Amplitude")
xlim([0 2.3])
ylim([0 1.3])

end