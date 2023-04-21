% Ƶ�׷���
function [Y, f] = FFTAnalysis(y, Ts)%yΪ�����źţ�TsΪ�������
Fs = 1/Ts;%������
L = length(y);%�źų���
NFFT = 2^nextpow2(L);
%nextpow2(x)��������ָ����
%����ָ��a����2��a�η����ڵ�������ֵx��2��a-1�η�С������ֵ��
%��nextpow2(128)=7,nextpow2(129)=8;

y = y - mean(y);%mean����ƽ��ֵ�����ھ���x��˵��mean(x,dim),��dim=1����������dim=2��������
Y = fft(y, NFFT)/L;
Y = 2*abs(Y(1:NFFT/2+1));
f = Fs/2*linspace(0, 1, NFFT/2+1);
end
