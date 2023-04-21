% Hilbert分析
function [yenvelope, yf, yh, yangle] = HilbertAnalysis(y, Ts)
yh = hilbert(y);
yenvelope = abs(yh);% 包络
yangle = unwrap(angle(yh));% 相位
yf = diff(yangle)/2/pi/Ts;% 瞬时频率
end
