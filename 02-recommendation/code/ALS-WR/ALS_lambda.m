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
d = 40;
Iterations = 5;
nlimit = 40;
trainMSE = zeros(1,nlimit);
testMSE = zeros(1,nlimit);

for lambda = 1:nlimit
    [U, V] = ALS_WR(traindata,testdata,M,d,lambda*0.01,Iterations);
    X = U*V';
    [trainMSE(lambda),testMSE(lambda)] = calcMSE(traindata,testdata,X);
end
plot([1:40]*0.01,trainMSE,'r');hold on;
plot([1:40]*0.01,testMSE,'b');
title('�㷨����泬�����˵ı仯');
xlabel('��������');
ylabel('�������MSE');
legend(sprintf('trainMSE'),sprintf('testMSE'));
