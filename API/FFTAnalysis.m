% 频谱分析
function [Y, f] = FFTAnalysis(y, Ts)%y为输入信号，Ts为采样间隔
Fs = 1/Ts;%采样率
L = length(y);%信号长度
NFFT = 2^nextpow2(L);
%nextpow2(x)作用是求指数，
%所求指数a满足2的a次方大于等于输入值x，2的a-1次方小于输入值，
%如nextpow2(128)=7,nextpow2(129)=8;

y = y - mean(y);%mean是求平均值，对于矩阵x来说，mean(x,dim),若dim=1，对列求，若dim=2，对行求
Y = fft(y, NFFT)/L;
Y = 2*abs(Y(1:NFFT/2+1));
f = Fs/2*linspace(0, 1, NFFT/2+1);
end
