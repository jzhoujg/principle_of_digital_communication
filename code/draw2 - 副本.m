yd = 10;
jam = 10:1:30;

Cs = [];
for i = 1:1:21
    Cs = [Cs log2(1+yd)-log2((1+yd)/jam(i))];
    
end
plot(jam-10,Cs)
xlabel('relaypower/dB');
ylabel('Cs');
title('ergodic secrecy capacity')
grid on;