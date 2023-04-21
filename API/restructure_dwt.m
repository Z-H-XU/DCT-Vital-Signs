function restructure_signal = restructure_dwt(signal,f,wname,Fs)
% signal为对应重构信号
% f为对应重构信号的频率范围
% wname为小波函数（字符串格式）
% Fs为采样频率
% Fs = Fs/2;
N = length(signal);
point = (f(2)-f(1))/Fs *N;
point_low = f(1)/Fs *N;
n = 1;
X = zeros(N,1);
while(N/ 2^(n) -point_low >=0 )
    n = n + 1;
end
a = n - 1;
sum = 0;
while(1)
    sum = sum+ N/ 2^(n);
    if(sum >= point)
        break;
    end      
    n = n -1;
end
b = n - 1;
[Lo_D, Hi_D, Lo_R, Hi_R] = wfilters(wname);
[C, L] = wavedec(signal,a,Lo_D,Hi_D);

% E = norm(signal,2)^2;% 信号总能量
for m =b:1:a
    Y = wrcoef('d',C,L,wname,m);
%     weight = norm(Y,2)^2 /E;
%     X = X + weight *  Y;
    X = X + Y;
end
% X = sum(X',2)
[XD, CXD, LXD] = wdenoise(X,1,"Wavelet",wname);
restructure_signal = XD;