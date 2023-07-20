function result = fun_ode_normal_LIU(t,initial)
%在《基于动力学仿真和迁移学习的滚动轴承故障诊断方法研究》基础上，结合《球轴承剥落损伤双冲击机理建模及其量化研究.罗茂林》、《实验与仿真数据驱动的滚动轴承故障严重性评估研究．罗嘉宁》、
%《仿真数据驱动的滚动轴承深度迁移学习故障诊断方法研究．陈露》、《滚动轴承复合故障机理及振动模型研究.董振振》、《基于卷积神经网络的机械故障诊断域自适应算法研究.朱智字》多篇文章，

%达到仿真 ，转速为800r/mim正常轴承故障的目的


fr = 1800/60;                               %轴的转动频率
min = 50;                                   %内圈和轴的等效质量
kin = 7.42*10^7;                            %轴的连接刚度
cin = 1376.8;                               %轴的连接阻尼
mout = 5;                                   %外圈和轴承座的等效质量
kout = 1.51*10^7;                           %轴承座的连接刚度
cout = 2210.7;                              %轴承座的连接阻尼
k = 8.753*10^9;                             %内外圈和滚动体的接触刚度
g = 9.8;                                    %重力加速度
cr = 2*10^(-6);                             %径向游隙
e = 50*10^(-6);                             %轴和内圈的偏心距

n = 9;                                      %滚动体数量
db = 7.938*10^(-3);                         %滚动体直径
dp = 39.04*10^(-3);                         %轴承的节径


fhx = 0;
fhy = 0;

%开始计算接触形变
w = fr*2*pi;
wc = (1-db/dp*cos(0))*w/2;                 %保持架转动频率
sita = zeros(1,n);                         %n个滚动体和垂直方向的角度
sitar = pi/360;                            %随机滑动角度偏差

delta = zeros(1,n);                        %n个滚动体的形变量delta
fh = zeros(1,n);                           %由于形变量引起的弹性恢复力
for i = 1:n
    sita(i) = 2*pi*(i-1)/n + wc*t + (0.5 - rand(1,1))*sitar;   % 随机滑动因素
    %第i个滚动体的形变量  delta
    delta(i) = (initial(1) - initial(3))*sin(sita(i)) + (initial(5) - initial(7))*cos(sita(i)) - cr*(1-cos(abs(mod(sita(i),2*pi))));
    %第i个滚动体的弹性恢复力fh
    if(delta(i) > 0)
        fh(i) = k*(delta(i)^1.5);
    end
    fhx = fhx + fh(i)*sin(sita(i));
    fhy = fhy + fh(i)*cos(sita(i));
end


%离心力 fc
fc = e*min*w^2;



%求取内圈x方向的速度、加速度
x_in=zeros(2,1); % 列向量
x_in(1)=initial(2);   %x方向上的速度
x_in(2) = (-fhx + fc*cos(w*t) - kin*initial(1) - cin*initial(2))/min; %内圈x方向上的加速度

%求取内圈y方向的速度、加速度
y_in=zeros(2,1); % 列向量
y_in(1)=initial(6);   %y方向上的速度
y_in(2) = (min*g - fhy + fc*sin(w*t) - kin*initial(5) - cin*initial(6))/min; %内圈y方向上的加速度

%求取外圈x方向的速度、加速度
x_out=zeros(2,1); % 列向量
x_out(1)=initial(4);   %x方向上的速度
x_out(2) = (fhx - kout*initial(3) - cout*initial(4))/mout; %外圈x方向上的加速度

%求取外圈y方向的速度、加速度
y_out=zeros(2,1); % 列向量
y_out(1)=initial(8);   %y方向上的速度
y_out(2) = (fhy + mout*g - kout*initial(7) - cout*initial(8))/mout; %外圈y方向上的加速度

%依次为 内x 外x 内y  外y
result = [x_in(1);x_in(2);x_out(1);x_out(2);y_in(1);y_in(2);y_out(1);y_out(2)];

