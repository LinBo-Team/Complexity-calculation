function result = fun_ode_outer_LIU(t,initial,flag,Opt_parameters)
%�ڡ����ڶ���ѧ�����Ǩ��ѧϰ�Ĺ�����й�����Ϸ����о��������ϣ���ϡ�����а�������˫�������ģ���������о�.��ï�֡�����ʵ����������������Ĺ�����й��������������о����޼�������
%���������������Ĺ���������Ǩ��ѧϰ������Ϸ����о�����¶������������и��Ϲ��ϻ�����ģ���о�.�����񡷡������ھ��������Ļ�е�������������Ӧ�㷨�о�.�����֡���ƪ���£�

fr = 1800/60;                               %���ת��Ƶ��
min = 50;                                   %��Ȧ����ĵ�Ч����
kin = 7.42*10^7;                            %������Ӹն�
cin = 1376.8;                               %�����������
mout = 5;                                   %��Ȧ��������ĵ�Ч����
kout = 1.51*10^7;                           %����������Ӹն�
cout = 2210.7;                              %���������������
k = 8.753e9;                             %����Ȧ�͹�����ĽӴ��ն�
g = 9.8;                                    %�������ٶ�
cr = 2*10^(-6);                             %������϶
e = 50*10^(-6);                             %�����Ȧ��ƫ�ľ�

n = 9;                                     %����������
db = 7.938*10^(-3);                             %������ֱ��
rb = db/2;                                  %������İ뾶
dp = 39.04*10^(-3);                          %��еĽھ�
do = 47*10^(-3);                            %��е���Ȧֱ��
di = 31.10*10^(-3);                            %��е���Ȧֱ��
l = Opt_parameters;                         %ȱ�ݿ��
h = 1*10^(-3);                            %ȱ�����



fhx = 0;
fhy = 0;

%��ʼ����Ӵ��α�
w = fr*2*pi;
wc = (1-db/dp*cos(0))*w/2;                 %���ּ�ת��Ƶ��
sita = zeros(1,n);                         %n��������ʹ�ֱ����ĽǶ�
sitar = pi/360;                                 %��������Ƕ�ƫ��
fiout = 0*pi/180;                          %��������Ȧ���ϵ�λ��


delta = zeros(1,n);                        %n����������α���delta
sitas = fiout;
fis = asin(l/do);  %��������Ӧ����Ȧ���Ļ��ȴ�С��һ��
delta_d = zeros(1,n);
fh = zeros(1,n);                           %�����α�������ĵ��Իָ���


H  = zeros(1,n); 
if(8*rb*h >= (4*h^2+l^2))
    H0 = rb - (rb^2 - l^2/4)^0.5 - (do/2 - (do^2/4-l^2/4)^0.5);
else
    H0 = h;
end


for i = 1:n
    sita(i) = 2*pi*(i-1)/n + wc*t + (0.5 - rand(1))*sitar;
    %ȱ�ݸ���λ��
    if(cos(sita(i)-fiout) >= cos(l/do))
        H(i) = H0;
    end
    
%     ��i����������α���  delta
    delta(i) = (initial(1) - initial(3))*sin(sita(i)) + (initial(5) - initial(7))*cos(sita(i)) - cr*(1-cos(abs(mod(sita(i),2*pi)))) - H(i);      %����������� ��Ȧ���ϱ���h
%     ��i��������ĵ��Իָ���fh
    if(delta(i) > 0)
        fh(i) = k*delta(i)^(1.5);
    end
    fhx = fhx + fh(i)*sin(sita(i));
    fhy = fhy + fh(i)*cos(sita(i));
end




%������ fc
fc = e*min*w^2;


%��������
v2 = (5/14*g*db*(l/db)^2)^0.5+db/2*w;   %ͨ��ȱ�ݵ�ĩ�ٶ�
mgun = 4/3*pi*(db)^3*7.85*10^6;  %����������
chongliang = mgun*v2*2*(l/do);           %�����ĳ����
t_chongji = l/(2*w*dp);

f = chongliang/(t_chongji*(1-0.5*(l/db).^2));

Finpact = 0;
for i = 1:n    
    if(cos(sita(i)-fiout-l/di/2) >= cos(l/di))
        Finpact = f;
    end    
end
% Finpact = 0;


%��ȡ��Ȧx������ٶȡ����ٶ�
x_in=zeros(2,1); % ������
x_in(1)=initial(2);   %x�����ϵ��ٶ�
x_in(2) = (-fhx + fc*cos(w*t) - kin*initial(1) - cin*initial(2))/min; %��Ȧx�����ϵļ��ٶ�

%��ȡ��Ȧy������ٶȡ����ٶ�
y_in=zeros(2,1); % ������
y_in(1)=initial(6);   %y�����ϵ��ٶ�
y_in(2) = (min*g - fhy + fc*sin(w*t) - kin*initial(5) - cin*initial(6))/min; %��Ȧy�����ϵļ��ٶ�

%��ȡ��Ȧx������ٶȡ����ٶ�
x_out=zeros(2,1); % ������
x_out(1)=initial(4);   %x�����ϵ��ٶ�
x_out(2) = (Finpact*cos(l/di) + fhx - kout*initial(3) - cout*initial(4))/mout; %��Ȧx�����ϵļ��ٶ�

%��ȡ��Ȧy������ٶȡ����ٶ�
y_out=zeros(2,1); % ������
y_out(1)=initial(8);   %y�����ϵ��ٶ�
y_out(2) = (Finpact*sin(l/di) + fhy + mout*g - kout*initial(7) - cout*initial(8))/mout; %��Ȧy�����ϵļ��ٶ�

%����Ϊ ��x ��x ��y  ��y
result = [x_in(1);x_in(2);x_out(1);x_out(2);y_in(1);y_in(2);y_out(1);y_out(2)];

