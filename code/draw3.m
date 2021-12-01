clc;
clear all;
close all;
x = 1:1:12;
y = [0.335000000000000,0.290277777777778,0.236363636363636,0.184821428571429,0.156428571428571,0.0682432432432432,0.0371428571428571,0.0229729729729730,0.0112068965517241,0.00454950936663693,0.000757687758722649,0.0002]
values = spcrv([[x(1) x x(end)];[y(1) y y(end)]],3);

y2 = [0.269736842105263,0.166666666666667,0.132236842105263,0.0585227272727273,0.0401964285714286,0.0228794642857143,0.0200593607305936,0.0121428571428571,0.00703977272727273,0.00439778393351801,0.00190227527042148,0.000895548856180174];
values2 = spcrv([[x(1) x x(end)];[y2(1) y2 y2(end)]],3);

y3 = [0.101500000000000,0.095217391304348,0.0646875000000000,0.0506666666666667,0.0327922077922078,0.0204178082191781,0.0167491749174917,0.00902364394993046,0.00492990654205608,0.00404042553191489,0.00170244884267024,0.000905765546072113];
values3 = spcrv([[x(1) x x(end)];[y3(1) y3 y3(end)]],3);

y4 = [0.0897321428571429,0.0498437500000000,0.0465277777777778,0.0314682539682540,0.0206625766871166,0.0106398713826367,0.0086942148760331,0.00619212962962963,0.00579470198675497,0.00375643382352941,0.00198146687697161,0.000730322580645161];
values4 = spcrv([[x(1) x x(end)];[y4(1) y4 y4(end)]],3);
figure(1)



semilogy(values(1,:),values(2,:));
title('BER VS SNR');
xlabel('SNR/dB');
ylabel('BER');
hold on;

semilogy(values2(1,:),values2(2,:));
title('BER VS SNR');
xlabel('SNR/dB');
ylabel('BER');

hold on;

semilogy(values3(1,:),values3(2,:));
title('BER VS SNR');
xlabel('SNR/dB');
ylabel('BER');

hold on;

semilogy(values4(1,:),values4(2,:));
title('BER VS SNR');
xlabel('SNR/dB');
ylabel('BER');
legend('no relay','relay 0 dB gain','relay 3dB gain ','relay 6dB gain')

%semilogy(x,y1)