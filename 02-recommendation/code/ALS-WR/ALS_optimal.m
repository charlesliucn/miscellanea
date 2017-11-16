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
lambda = 0.40;
Iterations = 30;
[U, V] = ALS_WR(traindata,testdata,M,d,lambda,Iterations);
X = U*V';
[trainMSE,testMSE] = calcMSE(traindata,testdata,X);
fprintf('Final test MSE: %f!\n',testMSE);

save('X.mat','X');