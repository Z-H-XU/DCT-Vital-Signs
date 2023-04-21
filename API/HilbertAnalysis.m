% Hilbert����
function [yenvelope, yf, yh, yangle] = HilbertAnalysis(y, Ts)
yh = hilbert(y);
yenvelope = abs(yh);% ����
yangle = unwrap(angle(yh));% ��λ
yf = diff(yangle)/2/pi/Ts;% ˲ʱƵ��
end
