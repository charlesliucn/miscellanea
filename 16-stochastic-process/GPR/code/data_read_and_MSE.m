clear all;close all;clc;

%% ����1
clear;
load('question1.mat');

% ����д��������1�Ĵ���
addpath('./GPML');
LikeFunction = @likGauss;                                               % ��˹��Ȼ����
sn = 0.1;                                                               % ��˹��Ȼ�����Ĳ���
MeanFunction = @meanConst;                                              % ��ֵ����

Cov1 = {@covProd,{@covRQiso,@covPeriodic}};                             % RQ * Per
Cov2 = {@covSum,{@covLINiso,Cov1}};                                     % Lin + RQ
CovFunction = {@covProd,{@covSEiso,Cov2}};                              % SE * (Lin + RQ * Per)
feval(CovFunction{:})                                                   % �˺�����Ҫ�Ż��Ĳ�������

hyp.cov = zeros(9,1);hyp.mean = 0;hyp.lik = log(0.1);                   % ������ʼ��
hyp = minimize(hyp, @gp, -200, @infGaussLik, MeanFunction, CovFunction, LikeFunction, xtrain, ytrain);	% �����ݶȷ����Ż������
marlik1 = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, xtrain, ytrain);               % ��Ե��Ȼֵ
[ytest,~] = gp(hyp, @infGaussLik, MeanFunction, CovFunction, LikeFunction, xtrain, ytrain, xtest);      % ytest:�Բ������ݵ�Ԥ��

% plot(xtest,ytest, 'LineWidth', 2);hold on;plot(xtrain, ytrain);      	% ��ͼ
% axis([-40 25 -60 40]);
% title('Training Dataset v.s. Test Dataset');
% xlabel('Input:  x');
% ylabel('Output: y');

%  ����MSE
MSE1 = MSE_question2(ytest);                                            % ����MSE1

%% ����2
load('planecontrol.mat');
fprintf('����ʱ��ϳ��������ĵȴ�...\n');
% ����д��������2�Ĵ���
addpath('./GPML');
LikeFunction = @likGauss;                                            	% ��˹��Ȼ����
sn = 0.1;                                                               % ��˹��Ȼ�����Ĳ���
MeanFunction = @meanConst;                                              % ��ֵ����
x = xtrain(1:1000,:);y = ytrain(1:1000,:);                              % ѡȡһ����ѵ������

CovFunction = @covSEard;                                                % �˺���ΪSE(��ά)
hyp.cov = [zeros(40,1);0];hyp.mean = 0;hyp.lik = log(0.1);              % ������ʼ��

hyp = minimize(hyp, @gp, -200, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y); % �����ݶȷ��Ż�����
marlik2 = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);           	% ��Ե��Ȼֵ
[ytest,~] = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y,xtest);      % ytest:�Բ������ݵ�Ԥ��

% ����MSE
MSE2 = MSE_plane_control(ytest);                                        %����MSE2