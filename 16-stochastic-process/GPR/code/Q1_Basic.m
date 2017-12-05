%% �ļ�˵��
% ��.m�ļ���ͼʹ��һЩ�����ĺ˺��������ø�˹���̻ع飬����question1.mat�ṩ�Ĳ������ݽ������ʵ�ģ�͡�
% ����ģ�͹̶���ֵ��������Ȼ�������ƶϷ�����ֻ�о��˺�����ģ�ͽ�����Ӱ�졣
% �漰�ĺ˺���������SE��Per��Lin��RQ����Ԥ��������ݺ�õ���MSE����ģ�͵�Ч����

%% ׼������
clear all;close all;clc;
load('question1.mat');
addpath('./GPML');
x = xtrain;
y = ytrain;
z = xtest;

%% ����ѵ������(����ά��Ϊһά)��ͼ��
figure(1);
plot(x,y);                                          %��ͼֱ�۱���ѵ�������������֮��Ĺ�ϵ
title('Plot of Training Dataset');
xlabel('Input:  xtrain');
ylabel('Output: ytrain');
axis([-40,20,-50,40]);                                                      %�������귶Χ

%% Ĭ�Ͼ�ֵ��������Ȼ����
MeanFunction = {@meanSum, {@meanLinear, @meanConst}};                           %��ֵ����
LikeFunction = @likGauss;                                                   % ��˹��Ȼ����
sn = 0.1;                                                             % ��˹��Ȼ�����Ĳ���

%% 1. ƽ��ָ��(SE)������Ϊ�˺���
tic;
CovFunction = @covSEiso;
hyp.cov = [0;0]; hyp.mean = [0;0];hyp.lik = log(0.1);                                                 %��������
hyp = minimize(hyp, @GPR, -100, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik = GPR(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m1,s2] = GPR(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��

figure(2);                                                            %��ͼ��
f = [m1 + 2*sqrt(s2); flip(m1 - 2*sqrt(s2),1)];                       %������Χ
fill([z; flip(z,1)], f, [7 7 7]/8);
hold on; plot(z, m1, 'LineWidth', 2); plot(x, y);                       %��ͼ
axis([-40 25 -50 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE1 = MSE_question2(m1);                                   %����������ݵ�MSE
toc;

%% 2. ����(Lin)�˺���
tic;
CovFunction = @covLINiso;                                                                           %���Ժ˺���
hyp.cov = 0; hyp.mean = [0; 0];hyp.lik = log(0.1);                                                  %������ʼ��
hyp = minimize(hyp, @GPR, -100, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);         %�����Ż�
[m2,s2] = GPR(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m2ΪԤ���ֵ��s2ΪԤ�ⷽ��

figure(3);
f = [m2 + 2*sqrt(s2); flip(m2 - 2*sqrt(s2),1)];
fill([z; flip(z,1)], f, [7 7 7]/8);
hold on; plot(z, m2, 'LineWidth', 2); plot(x, y);
axis([-40 25 -50 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE2 = MSE_question2(m2);      %����������ݵ�MSE
toc;
%% 3. �������(RQ)������Ϊ�˺���
tic;
CovFunction = @covRQiso;            %������κ���
hyp.cov = [0;0;0]; hyp.mean = [0; 0]; hyp.lik = log(0.1);
hyp = minimize(hyp, @GPR, -100, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);
[m3,s2] = GPR(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);

figure(4);
f = [m3 + 2*sqrt(s2); flip(m3 - 2*sqrt(s2),1)];
fill([z; flip(z,1)], f, [7 7 7]/8);
hold on; plot(z, m3, 'LineWidth', 2); plot(x, y);
axis([-40 25 -50 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE3 = MSE_question2(m3);
toc;
%% 4. SE�����ں�����Ϊ�˺���
tic;
CovFunction = @covPeriodic;
hyp.cov = [0;0;0]; hyp.mean = [0;0]; hyp.lik = log(0.5);
hyp = minimize(hyp, @GPR, -100, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);
[m4,s2] = GPR(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);

figure(5);
f = [m4 + 2*sqrt(s2); flip(m4 - 2*sqrt(s2),1)];
fill([z; flip(z,1)], f, [7 7 7]/8);
hold on; plot(z, m4, 'LineWidth', 2); plot(x, y);
axis([-40 25 -50 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');
MSE4 = MSE_question2(m4);
toc;
%% ��ͼ�Ƚϸ������˺����Ľ��
figure(6);
plot(z,m1,'r*');hold on;
plot(z,m2,'b','LineWidth', 2);hold on;
plot(z,m3,'g+');hold on;
plot(z,m4,'m.');hold on;
legend(sprintf('SE'),sprintf('Lin'),sprintf('RQ'),sprintf('Per'));
title('Structure Based on Basic Kernels','FontSize',14);
xlabel('Test Input','FontSize',14);ylabel('Test Output','FontSize',14);
