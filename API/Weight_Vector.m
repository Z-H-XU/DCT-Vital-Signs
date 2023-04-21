function weight = Weight_Vector(w,value,f,Fs,N)
%%%%
% w为权重
% value为权重值
% f 为频率
% Fs为采样率
% N为信号长度
% weight输出权重
%%%%
point1 = ceil(f(1)*N/Fs);
point2 = floor(f(2)*N/Fs);
% w(point1:point2,1) = value;
w(2*point1:2*point2,1) = value;
weight = w;

