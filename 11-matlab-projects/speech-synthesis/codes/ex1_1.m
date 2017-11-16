clear all,close all,clc;

a=[1,-1.3789,0.9506];       %���������ź�ϵ��
b=[1];                      %��������ź�ϵ��

%�����Ƶ��
[r,p,k]=residuez(b,a);      %��⼫��
fs=8000;                    %����Ƶ��ȡ8000Hz
OMG=abs(angle(p));          %��=��T=��/fs
fp=OMG*fs/(2*pi)            %f=��/(2*pi)

%��zplane,freq,impz�ֱ����㼫��ֲ�ͼ��Ƶ����Ӧ�͵�λ��ֵ��Ӧ��
zplane(b,a);                %zplane���㼫��ֲ�ͼ   
figure;                     %������ͼ��
freqz(b,a);                 %freq��Ƶ����Ӧ
figure;                     %������ͼ��
impz(b,a);                  %impz����λ��ֵ��Ӧ
set(gca,'XLim',[0,200]);    %�޸�x��Χ

%��filter�����λ��ֵ��Ӧ
figure;                     %������ͼ��
n=[0:200]';                 %����ʱ���
x=(n==0);                   %�Ե�λ��ֵ������Ϊ�����ź�
imp=filter(b,a,x);          %filter��λ��ֵ��Ӧ
stem(n,imp);                %������λ��ֵ��Ӧ

%�Ƚ�impz��filter����ĵ�λ��ֵ��Ӧ�Ƿ���ͬ
figure;                     %������ͼ��
impz(b,a);                  %��impz������λ��ֵ��Ӧ
set(gca,'XLim',[0,200]);    %�޸�x��Χ
hold on;                    %��������ͼ
stem(n,imp,'k-');           %��filter������λ��ֵ��Ӧ



