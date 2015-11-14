% script to run experiments

i=0;
save icounter.mat i;

diary('experiment_diary.m')

for j=1:5

load icounter.mat

global l retransmit_counter packets_sent packet_number packet_array ...
    txGain rxGain centerFreqTx centerFreqRx decFactor ...
     energySamples

switch i
    case 0
        %packet counters
        retransmit_counter= 0;
        packets_sent = 0;
        packet_number = 0;
        %mex parameters
        decFactor = 500;
        txGain = 25;
        rxGain = 30;
        centerFreqTx = 1.285e9;
        centerFreqRx = 1.284e9;
        %begin experiment
        start=clock;
        dtx_PHY_Layer
        stop=clock;
        %calculations
        b=packet_array(packet_array>1);
        c=b-1;
        p=sum(c);
        perror=p/packets_sent;
        totaltime=etime(stop,start);
        throughput=l/totaltime;
        latency=totaltime/packets_sent;
        numRetransmits=retransmit_counter;
        packetError=numRetransmits/packets_sent;
        %save and exit
        timestamp=clock;
        save gain15.mat

% 
%     case 1
%         %packet counters
%         retransmit_counter= 0;
%         packets_sent = 0;
%         packet_number = 0;
%         %mex parameters
%         decFactor = 500;
%         txGain = 30
%         rxGain = 30
%         centerFreqTx = 1.285e9
%         centerFreqRx = 1.284e9
%         %begin experiment
%         start=clock;
%         dtx_PHY_Layer
%         stop=clock;
%         %calculations
%         b=packet_array(packet_array>1);
%         c=b-1;
%         p=sum(c);
%         perror=p/packets_sent;
%         totaltime=etime(stop,start);
%         throughput=l/totaltime;
%         latency=totaltime/packets_sent;
%         numRetransmits=retransmit_counter;
%         packetError=numRetransmits/packets_sent;
%         %save and exit
%         timestamp=clock;
%         save gain30.mat
% 
% 
%     case 2
%         %packet counters
%         retransmit_counter= 0;
%         packets_sent = 0;
%         packet_number = 0;
%         %mex parameters
%         decFactor = 500;
%         txGain = 25
%         rxGain = 30
%         centerFreqTx = 1.285e9
%         centerFreqRx = 1.284e9
%         %begin experiment
%         start=clock;
%         dtx_PHY_Layer
%         stop=clock;
%         %calculations
%         b=packet_array(packet_array>1);
%         c=b-1;
%         p=sum(c);
%         perror=p/packets_sent;
%         totaltime=etime(stop,start);
%         throughput=l/totaltime;
%         latency=totaltime/packets_sent;
%         numRetransmits=retransmit_counter;
%         packetError=numRetransmits/packets_sent;
%         %save and exit
%         timestamp=clock;
%         save gain25.mat
% 
%     case 3
%         %packet counters
%         retransmit_counter= 0;
%         packets_sent = 0;
%         packet_number = 0;
%         %mex parameters
%         decFactor = 500;
%         txGain = 20
%         rxGain = 30
%         centerFreqTx = 1.285e9
%         centerFreqRx = 1.284e9
%         %begin experiment
%         start=clock;
%         dtx_PHY_Layer
%         stop=clock;
%         %calculations
%         b=packet_array(packet_array>1);
%         c=b-1;
%         p=sum(c);
%         perror=p/packets_sent;
%         totaltime=etime(stop,start);
%         throughput=l/totaltime;
%         latency=totaltime/packets_sent;
%         numRetransmits=retransmit_counter;
%         packetError=numRetransmits/packets_sent;
%         %save and exit
%         timestamp=clock;
%         save gain20.mat
% 
%     case 4
%         %packet counters
%         retransmit_counter= 0;
%         packets_sent = 0;
%         packet_number = 0;
%         %mex parameters
%         decFactor = 500;
%         txGain = 15
%         rxGain = 30
%         centerFreqTx = 1.285e9
%         centerFreqRx = 1.284e9
%         %begin experiment
%         start=clock;
%         dtx_PHY_Layer
%         stop=clock;
%         %calculations
%         b=packet_array(packet_array>1);
%         c=b-1;
%         p=sum(c);
%         perror=p/packets_sent;
%         totaltime=etime(stop,start);
%         throughput=l/totaltime;
%         latency=totaltime/packets_sent;
%         numRetransmits=retransmit_counter;
%         packetError=numRetransmits/packets_sent;
%         %save and exit
%         timestamp=clock;
%         save gain15.mat
end

i=i+1;
save icounter.mat i;

clear all; close all; clear classes; clc; clear mex; findsdru

end


diary off