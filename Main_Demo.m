
% --------------------------------------------------------------------------------------------------
%
%    Demo software for Simultaneous Extraction of Driver Breathing and Heartbeat
%    Radar Signals Using Discrete Cosine Transform-Based Sparse Optimization
%
%                   Release ver. 1.0  (April. 21, 2023)
%
% --------------------------------------------------------------------------------------------
%
% authors:           S.K. Xue, Zhihuo Xu, Y.X. Wang  et al.
%
% web page:           https://github.com/Z-H-XU/DCT-Vital-Signs
%
% contact:               xuzhihuo@gmail.com
%
% --------------------------------------------------------------------------------------------
% Copyright (c) 2023 NTU.
% Nantong University, China.
% All rights reserved.
% This work should be used for nonprofit purposes only.
% --------------------------------------------------------------------------------------------
% If you use the code, please kindly cite the following paper:  
% S.K. Xue, Zhihuo Xu, Y.X. Wang  et al. : Discrete Cosine Transform-Based Sparse Optimization
% for Simultaneous Extraction of Driver Breathing and Heartbeat Radar Signals. 
% IEEE Transactions on Intelligent Transportation Systems, Under Review.
% Thank you!

clc;clear;
close all;

%% Load respiratory reference sensor and radar sensor data

 path=cd();

 addpath(path,"API");

% Select the test data case
data_case=2; 

switch data_case
   case 1
      load('data1.mat');  % the first case for driver fatigue
   case 2
      load('data2.mat');  % the second case for driver fatigue
end

fs_breathing=50;
fs_radar = 2560;     

PLotsON;              % figure configure

figure
t_breath=0:1/fs_breathing:(length(respiration)-1)/fs_breathing;
plot(t_breath,respiration/max(respiration));
xlim([0  t_breath(end)])
ylim([-1.2 1.2])
xlabel("Time (s)")
ylabel("Normalized Amplitude")
title('Respiratory reference sensor data')


%% Remove DC offset
radar_Imall=radar_I-mean(radar_I);
radar_Qmall=radar_Q-mean(radar_Q);

%% Phase unwrap
wrapped_phase = atan2(radar_Qmall,radar_Imall);     
unwrapped_phase = unwrap(wrapped_phase);

%% Phase Difference
n = length(unwrapped_phase);
t = 0:1/fs_radar:(n-1)/fs_radar;  % axis of  time    
f = fs_radar/n *(0:(n-1));            % axis of frequency

figure
plot(t,unwrapped_phase/max(abs(unwrapped_phase)));
xlim([0  t(end)])
ylim([-1.2 1.2])
xlabel("Time (s)")
ylabel("Normalized amplitude")
title('Radar phase signal ')


%% DWT
[dwt_res, dwt_heart] = DWT(unwrapped_phase,t,f,fs_radar,1);

%%  EMD
[breathe_EMD, heartbeat_EMD] = EMD(unwrapped_phase,t,f,fs_radar,1);

%% CS-OMP
[x_res,x_heart] = CS_OMP(unwrapped_phase,t,f,fs_radar,1);

%% Proposed method
[y_res, y_heart] = DCT_Sparse(unwrapped_phase,t,f,fs_radar,6,1);

PLotsOFF
