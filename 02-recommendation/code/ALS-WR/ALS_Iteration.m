clear all;close all;clc;

%% ׼������
% �趨�����ֵ
nuser = 943;                                            % �û���Ŀ
nitem = 1682;                                           % ��Ʒ(��Ӱ����Ʒ��)����
ntrain = 80000;                                         % ѵ������С
ntest = 10000;                                          % ���Լ���С
% ׼������
load('data_train.mat');                                 % ��������
[ttlnum,~] = size(data_train);                          % ����������������
% �����ݽ��д�������Ϊѵ�����Ͳ��Լ�
split = randperm(ttlnum);                               % randperm�������
traindata = data_train(split(1:ntrain),:);              % ȡǰntrain����Ϊѵ����
testdata = data_train(split(ttlnum-ntest+1:end),:);     % ʣ�µ�ntest����Ϊ��������

%% �����ݼ���ԭΪ������ʽ
% �����ʼ��
M = zeros(nuser,nitem);
for i = 1:ntrain
    u = traindata(i,1);
    v = traindata(i,2);
    M(u,v) = traindata(i,3);
end

%% ʹ��ALS_WR�㷨����U��V
lambda = 0.20;
Iterations = 40;
d = 40;
[trainMSE,testMSE] = ALS_WR_Iter(traindata,testdata,M,d,lambda,Iterations);

plot(1:Iterations,trainMSE,'r');hold on;
plot(1:Iterations,testMSE,'b');
title('�㷨�������������ı仯');
xlabel('��������');
ylabel('�������MSE');
legend(sprintf('trainMSE'),sprintf('testMSE'));
% 
% plot(1:Iterations,testMSE,'b');
% xlabel('��������');
% ylabel('�������MSE');
% title('���Լ���MSE����������ı仯');
