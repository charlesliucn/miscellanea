%% �ļ�˵��
% ��.m�ļ�����ʹ��һЩ�����˺����ļӳ˸��ϣ����ø�˹���̻ع飬����question1.mat�ṩ�Ĳ������ݽ������ʵ�ģ�͡�
% ����ֵ��������Ȼ�������ƶϷ�����ֻ�о��˺���(Kernel)��ģ�ͽ�����Ӱ�졣
% �漰�ĺ˺���������SE��Per��Lin��RQ��ͨ���ӷ��˷�����Ԥ��������ݺ�õ���MSE����ģ�͵�Ч����
% �˺������㣺
%   �ӷ��� A + B -------- {@covSum,{A,B}}
%   �˷��� A * B -------- {@covProd,{A,B}}

%% ׼������
clear all;close all;clc;
load('question1.mat');
addpath('./GPML');
x = xtrain;
y = ytrain;
z = xtest;
% Ĭ����Ȼ����������
LikeFunction = @likGauss;                                                   % ��˹��Ȼ����
sn = 0.1;                                                             % ��˹��Ȼ�����Ĳ���

%% ����ѵ������(����ά��Ϊһά)��ͼ��
figure(1);
plot(x,y,'b','LineWidth',1.5);                                          %��ͼֱ�۱���ѵ�������������֮��Ĺ�ϵ
title('Plot of Training Dataset','FontSize',14);
xlabel('Input:  xtrain','FontSize',14);
ylabel('Output: ytrain','FontSize',14);
axis([-35,15,-40,30]);                                                      %�������귶Χ

%% ��ֵ����ΪConst
MeanFunction = @meanConst;                           %��ֵ����

%% ����ģ��һ
% SE + SE*PER + RQ + SE+WN;
Cov1 = {@covProd,{@covSEiso,@covPeriodic}};
Cov2 = {@covSum,{@covSEiso,@covNoise}};
CovFunction = {@covSum,{@covSEiso,Cov1,@covRQiso,Cov2}};
feval(CovFunction{:})

tic;
hyp.cov = zeros(13,1);hyp.mean = 0;hyp.lik = log(0.1);                    %��������
hyp = minimize(hyp, @gp, -200, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik1 = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m1,s2] = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
m1 = m1-2*sqrt(s2);
toc;
figure(2);                                                            %��ͼ��
plot(z, m1, 'LineWidth', 2); hold on;plot(x, y);                       %��ͼ
axis([-40 25 -60 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE1 = MSE_question2(m1);                                   %����������ݵ�MSE

%% ����ģ�Ͷ�
% LIN*SE + SE*PER + SE*RQ
Cov1 = {@covProd,{@covLINiso,@covSEiso}};
Cov2 = {@covProd,{@covSEiso,@covPeriodic}};
Cov3 = {@covProd,{@covSEiso,@covRQiso}};
CovFunction = {@covSum,{Cov1,Cov2,Cov3}};
feval(CovFunction{:})

tic;
hyp.cov = zeros(13,1);hyp.mean = 0;hyp.lik = log(0.1);                    %��������
hyp = minimize(hyp, @gp, -200, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik2 = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m2,s2] = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
toc;

figure(3);                                                            %��ͼ��
f = [m2 + 2*sqrt(s2); flip(m2-2*sqrt(s2),1)];                       %������Χ
fill([z; flip(z,1)], f, [7 7 7]/8);
hold on; plot(z, m2, 'LineWidth', 2); plot(x, y);                       %��ͼ
axis([-40 25 -60 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE2 = MSE_question2(m2);                                   %����������ݵ�MSE

%% ����ģ����
% SE*(LIN + RQ*PER)
Cov1 = {@covProd,{@covRQiso,@covPeriodic}};
Cov2 = {@covSum,{@covLINiso,Cov1}};
CovFunction = {@covProd,{@covSEiso,Cov2}};
feval(CovFunction{:})

tic;
hyp.cov = zeros(9,1);hyp.mean = 0;hyp.lik = log(0.1);                    %��������
hyp = minimize(hyp, @gp, -200, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik3 = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m3,s2] = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
toc;

figure(4);                                                            %��ͼ��
f = [m3 + 2*sqrt(s2); flip(m3-2*sqrt(s2),1)];                       %������Χ
fill([z; flip(z,1)], f, [7 7 7]/8);
hold on; plot(z, m3, 'LineWidth', 2); plot(x, y);                       %��ͼ
axis([-40 25 -60 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE3 = MSE_question2(m3);                                   %����������ݵ�MSE

%******************************************************************************%
%******************************************************************************%
%% ��ֵ����Ϊ Lin + Const    
MeanFunction = {@meanSum,{@meanLinear,@meanConst}};                  %��ֵ����

%% ����ģ��һ
% SE + SE*PER + RQ + SE+WN;
Cov1 = {@covProd,{@covSEiso,@covPeriodic}};
Cov2 = {@covSum,{@covSEiso,@covNoise}};
CovFunction = {@covSum,{@covSEiso,Cov1,@covRQiso,Cov2}};
feval(CovFunction{:})

tic;
hyp.cov = zeros(13,1);hyp.mean = [0;0];hyp.lik = log(0.1);                    %��������
hyp = minimize(hyp, @gp, -200, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik4 = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m4,s2] = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
m4 = m4 + 2*sqrt(s2);
toc;

figure(5);                                                            %��ͼ��
plot(z, m4, 'LineWidth', 2); hold on;plot(x, y);                       %��ͼ
axis([-40 25 -60 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE4 = MSE_question2(m4);                                   %����������ݵ�MSE

%% ����ģ�Ͷ�
% LIN*SE + SE*PER + SE*RQ
Cov1 = {@covProd,{@covLINiso,@covSEiso}};
Cov2 = {@covProd,{@covSEiso,@covPeriodic}};
Cov3 = {@covProd,{@covSEiso,@covRQiso}};
CovFunction = {@covSum,{Cov1,Cov2,Cov3}};

tic;
hyp.cov = zeros(13,1);hyp.mean = [0;0];hyp.lik = log(0.1);                    %��������
hyp = minimize(hyp, @gp, -200, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik5 = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m5,s2] = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
toc;

figure(6);                                                            %��ͼ��
f = [m5 + 2*sqrt(s2); flip(m5-2*sqrt(s2),1)];                       %������Χ
fill([z; flip(z,1)], f, [7 7 7]/8);
hold on; plot(z, m5, 'LineWidth', 2); plot(x, y);                       %��ͼ
axis([-40 25 -60 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE5 = MSE_question2(m5);                                   %����������ݵ�MSE

%% ����ģ����
% SE*(LIN + RQ*PER)

Cov1 = {@covProd,{@covRQiso,@covPeriodic}};
Cov2 = {@covSum,{@covLINiso,Cov1}};
CovFunction = {@covProd,{@covSEiso,Cov2}};
feval(CovFunction{:})

tic;
hyp.cov = zeros(9,1);hyp.mean = [0;0];hyp.lik = log(0.1);                    %��������
hyp = minimize(hyp, @gp, -200, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik6 = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m6,s2] = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
toc;

figure(7);                                                            %��ͼ��
f = [m6 + 2*sqrt(s2); flip(m6-2*sqrt(s2),1)];                       %������Χ
fill([z; flip(z,1)], f, [7 7 7]/8);
hold on; plot(z, m6, 'LineWidth', 2); plot(x, y);                       %��ͼ
axis([-40 25 -60 40]);
title('Training Dataset v.s. Test Dataset');
xlabel('Input:  x');
ylabel('Output: y');

MSE6 = MSE_question2(m6);                                   %����������ݵ�MSE


%% ��ͼ�Ƚ�6��ģ��Ч��
figure(8);
plot(z,m1,'r','LineWidth', 2);hold on;
plot(z,m2,'m','LineWidth', 2);hold on;
plot(z,m3,'c','LineWidth', 2);hold on;
plot(z,m4,'k','LineWidth', 2);hold on;
plot(z,m5,'g','LineWidth', 2);hold on;
plot(z,m6,'b','LineWidth', 2);hold on;

legend( sprintf('Mean:Const; Kernel:Model 1'),...
        sprintf('Mean:Const; Kernel:Model 2'),...
        sprintf('Mean:Const; Kernel:Model 3'),...
        sprintf('Mean:Const+Lin; Kernel:Model 1'),...
        sprintf('Mean:Const+Lin; Kernel:Model 2'),...
        sprintf('Mean:Const+Lin; Kernel:Model 3'))
title('Structure Based on Composite Kernels','FontSize',14);
xlabel('Test Input','FontSize',14);ylabel('Test Output','FontSize',14);
