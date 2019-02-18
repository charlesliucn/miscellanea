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
Iterations = 5;
nlimit = 40;
trainMSE = zeros(1,nlimit);
testMSE = zeros(1,nlimit);

for d = 1:nlimit
    [U, V] = ALS_WR(traindata,testdata,M,d*5,lambda,Iterations);
    X = U*V';
    [trainMSE(d),testMSE(d)] = calcMSE(traindata,testdata,X);
end
plot([1:40]*5,trainMSE,'r');
plot([1:40]*5,testMSE,'b');
title('�㷨�������������d�ı仯');
xlabel('�㷨������d');
ylabel('�������MSE');
legend(sprintf('trainMSE'),sprintf('testMSE'));
% 
% plot([1:40]*5,testMSE,'b');
% xlabel('�㷨������d');
% ylabel('�������MSE');
% title('���Լ���MSE����������d�ı仯');