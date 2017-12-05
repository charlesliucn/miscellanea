clear all,close all,clc;

M_run = 20;            %AIS�㷨�����д���
beta = [0:1/1000:0.5 0.5:1/10000:0.9 0.9:1/100000:1.0];  %ѡȡ��beta����������paper�н����
load('test.mat');
load ('h10.mat');
W = parameter_W;        %RBM��Ȩ�ؾ���W
a = parameter_a;        %���ز��bias����a
b = parameter_b;        %�ɼ����bias����b
N = 10;
LogZ1 = zeros(1,N);
LogZ2 = zeros(1,N);
for i = 1:N
    LogZ1(i) = AIS1(W,a,b,M_run,beta);
    LogZ2(i) = AIS2(W,a,b,M_run,beta,testbatchdata);
end
 Mean1 = mean(LogZ1);
 Var1 = var(LogZ1);

 Mean2= mean(LogZ2);
 Var2 = var(LogZ2);

plot(LogZ1,'-*');hold on;
plot(LogZ2,'->r');hold on;
ylim([150,250]);
title('AIS�㷨ѡȡ��ͬbase-rate modelʱ��һ�������Ĺ���ֵ');
xlabel('���д���');
ylabel('logZ(��һ������ȡ��Ȼ����)');