clear all,close all,clc;

a=[1,-1.3789,0.9506];       %���������ź�ϵ��
b=[1];                      %��������ź�ϵ��
[z,p,k]=tf2zp(b,a);         %���9.2.1(1)����
fs=8000;                    %����Ƶ��ȡ8000Hz
delta_omg=2*pi*150/fs.*sign(angle(p));  %�Ƶ��Ĺ�ʽ�еġ�����
pn=p.*exp(1i*delta_omg);                %�õ�����������¼���
[B,A]=zp2tf(z,pn,k);                    %��zp2tf�����õ�ϵ������A,B





