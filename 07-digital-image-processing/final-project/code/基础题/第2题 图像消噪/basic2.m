clear all;close all;clc;
%% �������2С�⣺ͼ������
% by ��47 ��ǰ 2014011216

%% ����ͼƬ��׼������
lena = imread('Lena.bmp');
[height, width] = size(lena);
imwrite(lena,'Lena.png');

%% 1.��Lenaͼ��Ӹ�˹�ͽ�������
%��Ӹ�˹����
mu = 20;        % ��˹������ֵ
sigma = 5;    % ��˹��������
% gaussian_noise = sqrt(sigma2) * randn(height,width) + mu;	% ��˹����
gaussian_noise = normrnd(mu,sigma,height,width);            % ��˹����
lena_gn = lena + uint8(gaussian_noise);                 	% ����˸�˹������Lenaͼ
imshow(lena_gn);
imwrite(lena_gn,'GN.png');

%��ӽ�������
Pa = 0.1;                       % ����ɫ���������ָ���
Pb = 0.2;                       % ����ɫ���������ָ���
I1 = rand(height,width) < Pa;
I2 = rand(height,width) < Pb;
lena_sn = lena;
lena_sn(I1&I2) = 0;
lena_sn(I1&~I2) = 255;
figure;imshow(lena_sn);

%% 2. ʹ�þ�ֵ�˲�����ֵ�˲����ַ�����������
% ������˹����
    figure;
    lena_gn_mean = meanfilter(lena_gn,3);       % ʹ��3*3��ģ�������˸�˹������Lenaͼȥ��:��ֵ�˲�
    lena_gn_medi = medifilter(lena_gn,3);       % ʹ��3*3��ģ�������˸�˹������Lenaͼȥ��:��ֵ�˲�
    % չʾ���
    subplot(2,2,1);imshow(lena);title('1.ԭʼLenaͼ');
    subplot(2,2,2);imshow(lena_gn);title('2.��Ӹ�˹������');
    subplot(2,2,3);imshow(lena_gn_mean);title('3.��ֵ�˲���');
    subplot(2,2,4);imshow(lena_gn_medi);title('4.��ֵ�˲���');

% ������������
    figure;
    lena_sn_mean = meanfilter(lena_sn,3);       % ʹ��3*3��ģ�������˽���������Lenaͼȥ��:��ֵ�˲�
    lena_sn_medi = medifilter(lena_sn,3);       % ʹ��3*3��ģ�������˽���������Lenaͼȥ��:��ֵ�˲�
    % չʾ���
    subplot(2,2,1);imshow(lena);title('1.ԭʼLenaͼ');
    subplot(2,2,2);imshow(lena_sn);title('2.��ӽ���������');
    subplot(2,2,3);imshow(lena_sn_mean);title('3.��ֵ�˲���');
    subplot(2,2,4);imshow(lena_sn_medi);title('4.��ֵ�˲���');

%% 3. �����������������ͷ�ֵ�����
PixelNum = height*width;
% (1) ��˹����
    % ��ֵ�˲�
    MSE1 = sum(sum((lena_gn_mean - lena).^2))/PixelNum;
    RMSE1 = sqrt(MSE1);
    PSNR1 = 10*log10(255*255/MSE1);
    % ��ֵ�˲�
    MSE2 = sum(sum((lena_gn_medi - lena).^2))/PixelNum;
    RMSE2 = sqrt(MSE2);
    PSNR2 = 10*log10(255*255/MSE2);

% (2) ��������
    % ��ֵ�˲�
    MSE3 = sum(sum((lena_sn_mean - lena).^2))/PixelNum;
    PSNR3 = 10*log10(255*255/MSE3);
    RMSE3 = sqrt(MSE3);
    % ��ֵ�˲�
    MSE4 = sum(sum((lena_sn_medi - lena).^2))/PixelNum;
    RMSE4 = sqrt(MSE4);
    PSNR4 = 10*log10(255*255/MSE4);