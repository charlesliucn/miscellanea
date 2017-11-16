clear all,close all,clc;
%�ÿ͹ۣ�PSNR�������۷������۱����Ч��
load jpegdecodes.mat;
load hall.mat;

hallg=hall_gray;         	%����ͼ��Ϊhall.mat�еĻҶ�ͼ��hall_gray
                            %���Ϊhallg,�������ԭʼ����hall_gray
[Height,Width]=size(hallg); %��ȡͼ���С
PixelNum=Height*Width;      %��������Ŀ�����ڼ���MSE
MSE=1/PixelNum*sum(sum((double(hallg_rec)-double(hallg)).^2));
                            %���ݹ�ʽ����MSE
PSNR=10*log10(255^2/MSE);   %���ݹ�ʽ����PSNR
subplot(1,2,1);             %��ͼ1
imshow(hallg);              %����ԭͼ
title('ԭͼ');              %�趨����
imwrite(hallg,'./chapter2_11/1ԭͼ.bmp');  %�����ͼƬ��������
subplot(1,2,2);            	%��ͼ2
imshow(hallg_rec);          %��������JPEG����ͽ���֮��ԭ�õ���ͼ
title('JPEG����븴ԭͼ');   %�趨����
imwrite(hallg_rec,'./chapter2_11/2JPEG����븴ԭͼ.bmp');  %�����ͼƬ��������