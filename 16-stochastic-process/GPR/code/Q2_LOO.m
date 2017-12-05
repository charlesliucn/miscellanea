clear all;close all;clc;

load('planecontrol.mat');
addpath('./GPML');
n = length(xtrain);
x = xtrain(1:1000,:);
y = ytrain(1:1000,:);
z = xtest;

%% 
LikeFunction = @likGauss;
sn = 0.1; 
%%
tic;
CovFunction = @covSEard;
% CovFunction = @ covSEiso;(Ч�����Բ���)
hyp.cov = [zeros(40,1);0];
hyp.lik = log(0.1);                                                                   %��������
hyp = minimize(hyp, @gp, -200, @infLOO, [], CovFunction, LikeFunction, x, y);       %������ʼ��
marlik1 = gp(hyp, @infLOO, [], CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m1,~] = gp(hyp, @infLOO, [], CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
MSE1 = MSE_plane_control(m1);
toc;
%%
tic;
CovFunction = @covLINard;
hyp.cov = zeros(40,1);
hyp.lik = log(0.1);                                                                   %��������
hyp = minimize(hyp, @gp, -200, @infLOO, [], CovFunction, LikeFunction, x, y);       %������ʼ��
marlik2 = gp(hyp, @infLOO, [], CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m2,~] = gp(hyp, @infLOO, [], CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
MSE2 = MSE_plane_control(m2);
toc;
%%
tic;
CovFunction = {@covSum,{@covLINard,@covSEard}};
hyp.cov = zeros(81,1);
hyp.lik = log(0.1);                                                                   %��������
hyp = minimize(hyp, @gp, -200, @infLOO, [], CovFunction, LikeFunction, x, y);       %������ʼ��
marlik3 = gp(hyp, @infLOO, [], CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m3,~] = gp(hyp, @infLOO, [], CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
MSE3 = MSE_plane_control(m3);
toc;
%% 
tic;
CovFunction = {@covProd,{@covLINard,@covSEard}};
hyp.cov = zeros(81,1);
hyp.lik = log(0.1);                                                                   %��������
hyp = minimize(hyp, @gp, -200, @infLOO, [], CovFunction, LikeFunction, x, y);       %������ʼ��
marlik4 = gp(hyp, @infLOO, [], CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m4,~] = gp(hyp, @infLOO, [], CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
MSE4 = MSE_plane_control(m4);
toc;
%%
MeanFunction = @meanConst;
hyp.mean = 0;
%%
tic;
CovFunction = @covSEard;
% CovFunction = @ covSEiso;(Ч�����Բ���)
hyp.cov = [zeros(40,1);0];
hyp.lik = log(0.1);                                                                   %��������
hyp = minimize(hyp, @gp, -200, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik5 = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m5,~] = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
MSE5 = MSE_plane_control(m5);
toc;
%%
tic;
CovFunction = @covLINard;
hyp.cov = zeros(40,1);
hyp.lik = log(0.1);                                                                   %��������
hyp = minimize(hyp, @gp, -200, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik6 = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m6,~] = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
MSE6 = MSE_plane_control(m6);
toc;
%%
tic;
CovFunction = {@covSum,{@covLINard,@covSEard}};
hyp.cov = zeros(81,1);
hyp.lik = log(0.1);                                                                   %��������
hyp = minimize(hyp, @gp, -200, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik7 = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m7,~] = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
MSE7 = MSE_plane_control(m7);
toc;
%% 
tic;
CovFunction = {@covProd,{@covLINard,@covSEard}};
hyp.cov = zeros(81,1);
hyp.lik = log(0.1);                                                                   %��������
hyp = minimize(hyp, @gp, -200, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);       %������ʼ��
marlik8 = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y);                     %��Ե��Ȼֵ
[m8,~] = gp(hyp, @infLOO, MeanFunction, CovFunction, LikeFunction, x, y, z);  %m1ΪԤ���ֵ��s2ΪԤ�ⷽ��
MSE8 = MSE_plane_control(m8);
toc;