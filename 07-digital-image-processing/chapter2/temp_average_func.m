clear all;close all;clc;

%% ׼������
imraw = imread('test.jpg');     % ��ȡͼƬ�ļ�
im = mat2gray(imraw);           % תΪ�Ҷ�ͼ
im = im(:,:,1);                 % ����ά��Ϊ1
figure(1);imshow(im);           % չʾԭʼͼƬ

%% ���ģ��(fspecialΪģ�����ú�����avearge��ʾƽ��ƽ���˲�)
r = 1;                                          % ģ���С
template = fspecial('average',[2*r+1,2*r+1]); 	% ����ƽ��ƽ��ģ��
img=imfilter(im,template,'replicate');          % ����ʱ�ı߽紦��
figure(2);imshow(img);
imshow(im - img);
