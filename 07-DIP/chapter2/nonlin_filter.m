clear all;close all;clc;

%% ׼������
imraw = imread('test.jpg');             % ��ȡͼƬ�ļ�
imraw = mat2gray(imraw);                % תΪ�Ҷ�ͼ
imraw = imraw(:,:,1);                   % ����ά��Ϊ1
figure(1);imshow(imraw);                % չʾԭʼͼƬ

%% ��ֵ�˲�
im_medfil = medfilt2(imraw);
figure;imshow(im_medfil,[4,4]);
figure;imshow(imraw - im_medfil);

%% 