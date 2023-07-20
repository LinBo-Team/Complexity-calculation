%ͨ������fun_ode_normal_LIU��ɽ��ϴ�ѧN205EM��Բ������������еĶ���ѧ����

clc
clear
fs = 10000;      %����Ƶ��
tspan=0:1/fs:60; %�������

%��ʼλ�� Initial displacement  ����Ϊ  ��x����λ�ơ��ٶ�   ��x����λ�ơ��ٶ�   ��y����λ�ơ��ٶ�    ��y����λ�ơ��ٶ�
initial=[0,0,0,0,0,0,0,0]; 

[t,result]=ode45(@fun_ode_normal_LIU,tspan,initial);   %[t,result]  ���� tΪʱ������ = tspan
%result�Ľ������Ϊ  ��x�����ٶȡ����ٶ�   ��x�����ٶȡ����ٶ�   ��y�����ٶȡ����ٶ�    ��y�����ٶȡ����ٶ�


len = 1024;                          %��ȡ�����ݳ���
st = 8192;                           %��ȡ����ʼλ��
t_plot = t(1:len);
result_plot = result(st:st+len,8);
signal = diff(result(:,8));
result_plot = diff(result_plot);
figure,plot(t_plot,result_plot*100,'b');
title('Acceleration in the y direction under normal state');
xlabel('t(s)');
ylabel('Acc.(g)');

%��FFT
Y = abs(fft(result_plot - mean(result_plot)));
N = size(Y,1);
f=fs/N*(0:1:N-1); %ÿ��Ƶ��
figure,plot(f(1:N/2),abs(Y(1:N/2)));
title('FFT');
xlim([0 600]);

% %��������
% Y = abs(fft(abs(hilbert(result_plot))-mean(abs(hilbert(result_plot)))));
% N = size(Y,1);
% f=fs/N*(0:1:N-1); %ÿ��Ƶ��
% figure,plot(f(1:N/2),abs(Y(1:N/2)));
% title('���������');
% xlim([0 600]);




