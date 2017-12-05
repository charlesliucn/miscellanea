clear all,close all,clc;
%% ˵��
% Ϊ��֤���ƽ����׼ȷ�ԣ�����AIS�㷨
% ����AIS�㷨���㸴�ӶȽϸߣ��������ʱ��ϳ��������ĵȴ���лл�� 
 fprintf(1,'��Ҫ�ż��������ĵȴ�O(��_��)O~...\n');
%% ׼������
load('test.mat');
[num1, num_hid, num2]=size(testbatchdata);      %��ȡ�������ݴ�С
num_test = num1*num2;
data = [];                                      %����������ݵĸ�ʽ
for i=1:num2
	data = [data; testbatchdata(:,:,i)];
end

M_run = 100;            %AIS�㷨�����д���
beta = [0:1/1000:0.5 0.5:1/10000:0.9 0.9:1/10000:1.0];  %ѡȡ��beta����������paper�н����
fprintf(1,'................׼���������.................\n');
%% ��һ����������ֵ�Ͳ��������ϵ�����Ȼֵ
load ('trained_h10.mat');
W = parameter_W;        %RBM��Ȩ�ؾ���W
a = parameter_a;        %���ز��bias����a
b = parameter_b;        %�ɼ����bias����b
LogZ1 = AIS2(W,a,b,M_run,beta,testbatchdata);
Log_Like1 =  LikeliHood(W,a,b,LogZ1,data,num_test);
fprintf(1,'............................................\n');
fprintf(1,'����h10.mat,��һ����������ֵ(ȡlog)Ϊ%6.6f\n',LogZ1);
fprintf(1,'����h10.mat,���������ϵ���ȻֵΪ%d\n',Log_Like1);
fprintf(1,'............................................\n');

load ('trained_h20.mat');
W = parameter_W;        %RBM��Ȩ�ؾ���W
a = parameter_a;        %���ز��bias����a
b = parameter_b;        %�ɼ����bias����b
LogZ2 = AIS2(W,a,b,M_run,beta,testbatchdata);
Log_Like2 =  LikeliHood(W,a,b,LogZ2,data,num_test);
fprintf(1,'.............................................\n');
fprintf(1,'����h20.mat,��һ����������ֵ(ȡlog)Ϊ%6.6f\n',LogZ2);
fprintf(1,'����h20.mat,���������ϵ���ȻֵΪ%d\n',Log_Like2);
fprintf(1,'.............................................\n');

load ('trained_h100.mat');
W = parameter_W;        %RBM��Ȩ�ؾ���W
a = parameter_a;        %���ز��bias����a
b = parameter_b;        %�ɼ����bias����b
LogZ3 = AIS2(W,a,b,M_run,beta,testbatchdata);
Log_Like3 =  LikeliHood(W,a,b,LogZ3,data,num_test);
fprintf(1,'.............................................\n');
fprintf(1,'����h100.mat,��һ����������ֵ(ȡlog)Ϊ%6.6f\n',LogZ3);
fprintf(1,'����h100.mat,���������ϵ���ȻֵΪ%d\n',Log_Like3);
fprintf(1,'.............................................\n');

load ('trained_h500.mat');
W = parameter_W;        %RBM��Ȩ�ؾ���W
a = parameter_a;        %���ز��bias����a
b = parameter_b;        %�ɼ����bias����b
LogZ4 = AIS2(W,a,b,M_run,beta,testbatchdata);
Log_Like4 =  LikeliHood(W,a,b,LogZ4,data,num_test);
fprintf(1,'.............................................\n');
fprintf(1,'����h500.mat,��һ����������ֵ(ȡlog)Ϊ%6.6f\n',LogZ4);
fprintf(1,'����h500.mat,���������ϵ���ȻֵΪ%d\n',Log_Like4);
fprintf(1,'.............................................\n');
