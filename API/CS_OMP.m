function [x_res,x_heart] = CS_OMP(unwrapped_phase,t,f,Fs,fig)
%%
if nargin < 5
    fig = 0;
else
    fig =1;
end
%%
n = length(unwrapped_phase);
CS_OMP_res = butterworth_low_pass_filter(unwrapped_phase,4,0.5,Fs);
CS_OMP_res =butterworth_high_pass_filter(CS_OMP_res,4,0.1,Fs);

L = 2^nextpow2(n); % L=2^M£¬ 

CS_OMP_res_fft = fft(CS_OMP_res,L)/L;

M = fix(10/Fs *L);        

Phi=eye(M,L);  


b = Phi * CS_OMP_res_fft;

x = OMP(Phi,b,1);         
x_res = real(fft(x)); 
x_res = x_res(1:n);

%%
CS_OMP_heart = butterworth_low_pass_filter(unwrapped_phase,4,2,Fs);
CS_OMP_heart =butterworth_high_pass_filter(CS_OMP_heart,4,0.8,Fs);

L = 2^nextpow2(n);  

CS_OMP_heart_fft = fft(CS_OMP_heart,L)/L;

M = fix(10/Fs *L);        

Phi=eye(M,L);  

b = Phi * CS_OMP_heart_fft;

x = OMP(Phi,b,1);         
x_heart = real(fft(x)); 
x_heart = x_heart(1:n);

%%
if fig == 1
    figure()                                       % Time domain of CS-OMP respiration 
    plot(t, x_res/max(abs(x_res))) 
    xlabel("Time (s)")
    ylabel("Normalized Amplitude")
    xlim([0  t(end)])
    ylim([-1.2 1.2])
    title('Respiration by CS-OMP')
    
    figure()                                        % Frequency domain of CS-OMP respiration 
    x_res_fft = abs(fft(x_res))/max(abs(fft(x_res)));
    plot(f, x_res_fft)  
    xlabel("Frequency (Hz)")
    ylabel("Normalized Amplitude")
    xlim([0 1])
    ylim([0 1.3])
    title('Respiration  by CS-OMP')
    
    figure()                                      % Time domain of CS-OMP heart
    plot(t, x_heart/max(abs(x_heart))) 
    xlabel("Time (s)")
    ylabel("Normalized Amplitude")
    xlim([0 t(end)])
    ylim([-1.2 1.2])
    title('Heart  by CS-OMP')
    
    figure()                                      % Frequency domain of CS-OMP heart 
    x_heart_fft = abs(fft(x_heart(1:n)))/max(abs(fft(x_heart(1:n))));
    plot(f, x_heart_fft)  
    xlabel("Frequency(Hz)")
    ylabel("Normalized Amplitude")
    xlim([0 2.3])
    ylim([0 1.3])
    title('Heart  by CS-OMP')
end

end