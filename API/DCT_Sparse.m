function [y_res, y_heart] =DCT_Sparse(unwrapped_phase,t,f,Fs,Nit,fig)
%%
if nargin < 6
    fig = 0;
else
    fig =1;
end
%%
n = length(unwrapped_phase);
radar_denoise =butterworth_high_pass_filter(unwrapped_phase,4,0.1,Fs);
N = 2^nextpow2(n);% N = 2^k
M = n;     
 %y = unwrapped_phase.';
y = radar_denoise.';
%% DCT basis1
H1 =  @(x) D(x,M,N)/sqrt(N);  % D
H1T = @(c) DT(c,M,N)/sqrt(N); % D^H
mu1 = 1000;
%  weight
w1 = 100*ones(N,1);
w1 = Weight_Vector(w1,1,[0.9 2],Fs,N);
w1 = Weight_Vector(w1,1000,[0.1 0.5],Fs,N);
%% DCT basis2
H2 =  @(x) D(x,M,N)/sqrt(N);
H2T = @(x) DT(x,M,N)/sqrt(N);
mu2 = 100;
w2 = 10*ones(N,1);
w2 = Weight_Vector(w2,1,[0.1 0.5],Fs,N);
w2 = Weight_Vector(w2,100,[0.8 2],Fs,N);
%% extract respiration and heartbeat
% Nit = 30;                   % Iterations
[y1,y2,c1,c2,costfn] = SparseOptimization(y, H1, H1T, 1, H2, H2T, 1, w1, w2, mu1, mu2, Nit);

y1 = H1(c1);
y2 = H2(c2);
y_res = y2;
y_heart = y1;
% fprintf('Maximum of residual = %g\n', max(abs(y - y1.' - y2.')))

if fig == 1
    figure()                    % cost(n)
    plot(1:Nit,costfn)
    xlim([0 Nit])
    box off
    title('Cost function')
    xlabel('Iterations')
    ylabel('Cost(n)')
    
    figure()
    plot(t,real(y2)/max(real(y2)))            % Time domain of proposed method respiration
    xlim([0  t(end)])
    ylim([-1.2 1.2])
    xlabel("Time (s)")
    ylabel("Normalized Amplitude")
    title('Respiration Signal by DCT-Sparse')
    
    figure()                                    % Frequency domain of proposed method respiration
    res_fft = abs(fft(y2))/max(abs(fft(y2)));
    plot(f, res_fft)  
    xlabel("Frequency (Hz)")
    ylabel("Normalized Amplitude")
    xlim([0 1])
    ylim([0 1.3])
    title('Respiration Signal by DCT-Sparse')

    figure()
    plot(t,real(y1)/max(real(y1)))            % Time domain of proposed method heart
    xlim([0  t(end)])
    ylim([-1.2 1.2])
    xlabel("Time (s)")
    ylabel("Normalized Amplitude")
    title('Heart Signal by DCT-Sparse')
    
    figure()                                    % Frequency domain of proposed method heart
    heart_fft = abs(fft(y1))/max(abs(fft(y1)));
    plot(f, heart_fft)  
    xlabel("Frequency (Hz)")
    ylabel("Normalized Amplitude")
    xlim([0 2.3])
    ylim([0 1.3])
    title('Heart Signal by DCT-Sparse')
end
end