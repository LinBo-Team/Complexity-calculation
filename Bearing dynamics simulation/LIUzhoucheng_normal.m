%通过调用fun_ode_normal_LIU完成江南大学N205EM型圆柱滚子正常轴承的动力学仿真

clc
clear
fs = 10000;      %采样频率
tspan=0:1/fs:60; %求解区间

%初始位移 Initial displacement  依次为  内x方向位移、速度   外x方向位移、速度   内y方向位移、速度    外y方向位移、速度
initial=[0,0,0,0,0,0,0,0]; 

[t,result]=ode45(@fun_ode_normal_LIU,tspan,initial);   %[t,result]  其中 t为时间序列 = tspan
%result的结果依次为  内x方向速度、加速度   外x方向速度、加速度   内y方向速度、加速度    外y方向速度、加速度


len = 1024;                          %截取的数据长度
st = 8192;                           %截取的起始位置
t_plot = t(1:len);
result_plot = result(st:st+len,8);
signal = diff(result(:,8));
result_plot = diff(result_plot);
figure,plot(t_plot,result_plot*100,'b');
title('Acceleration in the y direction under normal state');
xlabel('t(s)');
ylabel('Acc.(g)');

%做FFT
Y = abs(fft(result_plot - mean(result_plot)));
N = size(Y,1);
f=fs/N*(0:1:N-1); %每点频率
figure,plot(f(1:N/2),abs(Y(1:N/2)));
title('FFT');
xlim([0 600]);

% %做包络谱
% Y = abs(fft(abs(hilbert(result_plot))-mean(abs(hilbert(result_plot)))));
% N = size(Y,1);
% f=fs/N*(0:1:N-1); %每点频率
% figure,plot(f(1:N/2),abs(Y(1:N/2)));
% title('仿真包络谱');
% xlim([0 600]);




