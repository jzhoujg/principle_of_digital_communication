yd = 10;
jam = 0:1:30;

Cs = [];
for i = 1:1:31
    Cs = [Cs log2(1+yd+jam(i))-log2(1+yd)];
    
end
plot(jam,Cs)
xlabel('jammer/dB');
ylabel('Cs');
title('ergodic secrecy capacity')
grid on;