function y = soft(x, T)
a = T ./abs(x);
y = max(1 - T ./abs(x),0) .* x;