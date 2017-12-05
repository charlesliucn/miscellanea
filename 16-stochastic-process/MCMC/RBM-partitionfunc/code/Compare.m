clear all,close all,clc;

load('h10.mat');
load('test.mat');
Times = 10;

W = parameter_W;
a = parameter_a;
b = parameter_b;
batchdata = testbatchdata;

%% AIS
M_run = 10;            %AIS�㷨�����д���
beta = [0:1/1000:0.5 0.5:1/10000:0.9 0.9:1/10000:1.0];  %ѡȡ��beta����������paper�н����
LogZ1 = zeros(1,Times);
for i = 1:Times
    LogZ1(i) = AIS2(W,a,b,M_run,beta,batchdata);
end

%% TAP����
LogZ2 = zeros(1,Times);
for i = 1:Times
    LogZ2(i) = TAP2(W, a, b);
end

%% TAP����
LogZ3 = zeros(1,Times);
for i = 1:Times
    LogZ3(i) = TAP3(W, a, b);
end

%% TAP�Ľ�
LogZ4 = zeros(1,Times);
beta2 =[0:0.001:1];
N = 20;
for i = 1:Times
    LogZ4(i) = RTS(W,a,b,beta2,N);
end
%% 
M1 = mean(LogZ1);
M2 = mean(LogZ2);
M3 = mean(LogZ3);
M4 = mean(LogZ4);
Var1 = var(LogZ1);
Var2 = var(LogZ2);
Var3 = var(LogZ3);
Var4 = var(LogZ4);
plot(LogZ1,'-g.');hold on;
plot(LogZ2,'b:');hold on;
plot(LogZ3,'-r');hold on;
plot(LogZ4,'-k*');hold on;
ylim([200,250]);
legend(sprintf('AIS�㷨'),sprintf('TAP�㷨(���׽���)'),...
    sprintf('TAP�㷨(���׽���)'),sprintf('RTS�㷨'));
title('��ͬ�����㷨��h10.matģ�͵Ĺ�һ����������');
xlabel('���д���');
ylabel('��һ����������ֵ');