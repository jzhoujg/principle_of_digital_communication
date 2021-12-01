% clc;
% clear all;
% close all;
%source_code = [1,0,0,1,0,1,1]; % data
%source_encode =[source_code,mod(sum(source_code),2)];% 
errobits = 0;
total = 0;
ber_snr = [];

for(j=1:1:10)
    errobits = 0;
    total = 0;
    while errobits < 200
        SNR = j;
        n = 40;
        total = total + n;
        source=randi([0,1],[1,n]);% Montecarlo Method
        source_encode = (lteTurboEncode(source))';
        %source_encode =  source;
        pilot = [0,0,0,1,1,0,1,1];
        source_encode = [pilot,pilot,pilot,source_encode];
        data = 2 * source_encode -1  ;
        s_p_data = double(reshape(data,2,length(data)/2));
        y=[];
        y_in=[]; % I
        y_qd=[]; % Q

        for(i=1:length(data)/2)
            y1=s_p_data(1,i); % inphase component
            y2=s_p_data(2,i)*1j ;% Quadrature component
            y_in=[y_in y1]; % inphase signal vector
            y_qd=[y_qd y2]; %quadrature signal vector
            y=[y y1+y2]; % modulated signal vector
        end

        Tx_sig= 2*y; % transmitting signal after modulation


        % XXXXXXXXXXXXXXXXXXXXXXXXXXXX channel XXXXXXXXXXXXXXXXXXXXXXXXXX


        rayleighchan = comm.RayleighChannel('SampleRate',n,'MaximumDopplerShift',0.0001);
        Tx_sig=(rayleighchan((Tx_sig)'))'; 

        res2 = [Tx_sig;y];
        % figure(1)
        % scatter(real(Tx_sig),imag(Tx_sig));
        % grid on;
        % title('Signal After Fading ');


        Rx_sig=awgn(Tx_sig,SNR,'measured'); 
        % figure(2)
        % scatter(real(Rx_sig),imag(Rx_sig));
        % grid on;
        % title('Signal After AWGN ');
        % XXXXXXXXXXXXXXXXXXXXXXXXXXXX QPSK demodulation XXXXXXXXXXXXXXXXXXXXXXXXXX

        %pre_process%

        pilot_receive = Rx_sig(1:12);
        Rx_sig = Rx_sig(13:length(Rx_sig));

        P1 = (pilot_receive(1)+ pilot_receive(5)+ pilot_receive(9))/3;
        P2 = (pilot_receive(2)+ pilot_receive(6)+ pilot_receive(10))/3;
        P3 = (pilot_receive(3)+ pilot_receive(7)+ pilot_receive(11))/3;
        P4 = (pilot_receive(4)+ pilot_receive(8)+ pilot_receive(12))/3;

        Rx_data=[];

        for(i=1:1:(length(data)-24)/2)
           d = [];
           d(1) = abs(Rx_sig(i)-P1);
           d(2) = abs(Rx_sig(i)-P2);
           d(3) = abs(Rx_sig(i)-P3);
           d(4) = abs(Rx_sig(i)-P4);
           [m,index]= min(d);
           switch(index)
               case 1
                   out = [0,0];
               case 2
                   out = [0,1];
               case 3 
                   out = [1,0];
               otherwise
                   out = [1,1];
           end
           Rx_data=[Rx_data  out];
        end


        data_decode = (lteTurboDecode(Rx_data))';
        %data_decode =Rx_data;
        res = [source;data_decode];
        num_erro = sum(xor(source,data_decode)) ;
        errobits = num_erro +errobits;
        BER = errobits/total;
        % figure(3)
        % stem(Rx_data,'linewidth',3) 
        % title('Information after Receiveing ');
        % axis([ 0 11 0 1.5]), grid on;
    end
    ber_snr = [ber_snr BER]
end