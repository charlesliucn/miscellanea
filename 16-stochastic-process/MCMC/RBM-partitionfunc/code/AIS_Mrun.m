clear all,close all,clc;

M_run = [5:5:50];            %AIS�㷨�����д���
beta = [0:1/1000:0.5 0.5:1/10000:0.9 0.9:1/100000:1.0];  %ѡȡ��beta����������paper�н����
load('test.mat');
load ('h10.mat');
W = parameter_W;        %RBM��Ȩ�ؾ���W
a = parameter_a;        %���ز��bias����a
b = parameter_b;        %�ɼ����bias����b
N = length(M_run);
LogZ = zeros(1,N);
for i = 1:N
    LogZ(i) = AIS1(W,a,b,M_run(i),beta);
end

 plot(M_run,LogZ,'-*');
% ylim([Mean-20,Mean+20]);
% title('AIS�㷨(δ�Ż�)��RBM(������Ϊ10)ģ�͹�һ�������Ĺ���');
% xlabel('�������д���');
% ylabel('logZ(��һ������ȡ��Ȼ����)');

% plot(LogZ,'-*');
% ylim([Mean-5,Mean+5])
% title('AIS�㷨(�Ż�)��RBM(������Ϊ10)ģ�͹�һ�������Ĺ���');
% xlabel('�������д���');
% ylabel('logZ(��һ������ȡ��Ȼ����)');