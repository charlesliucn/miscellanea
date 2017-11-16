clear all;close all;clc;

%% ׼������
imraw = imread('test.jpg');             % ��ȡͼƬ�ļ�
imraw = mat2gray(imraw);                % תΪ�Ҷ�ͼ
imraw = imraw(:,:,1);                   % ����ά��Ϊ1
figure(1);imshow(imraw);                % չʾԭʼͼƬ

%% ���ģ��(average)
num = [1,2,5,10,20,50];
figure;
for i = 1:length(num)
    r = num(i);                                % ģ���С
    template = fspecial('average',[2*r+1,2*r+1]);       % ����ƽ��ƽ��ģ��
 	img1 = imfilter(imraw,template,'replicate');          % ����ʱ�ı߽紦��
    subplot(3,4,2*i-1);imshow(img1);
    subplot(3,4,2*i);imshow(imraw-img1);
end
figure;
for i = 1:length(num)
    r = num(i);                                % ģ���С
    template = fspecial('average',[2*r+1,2*r+1]);       % ����ƽ��ƽ��ģ��
 	img1 = imfilter(imraw,template,'symmetric');          % ����ʱ�ı߽紦��
    subplot(3,4,2*i-1);imshow(img1);
    subplot(3,4,2*i);imshow(imraw-img1);
end
figure;
for i = 1:length(num)
    r = num(i);                                % ģ���С
    template = fspecial('average',[2*r+1,2*r+1]);       % ����ƽ��ƽ��ģ��
 	img1 = imfilter(imraw,template,'circular');          % ����ʱ�ı߽紦��
    subplot(3,4,2*i-1);imshow(img1);
    subplot(3,4,2*i);imshow(imraw-img1);
end

%%
num = [1,2,5,10,20,50];
figure;
for i = 1:length(num)
    r = num(i);                                % ģ���С
    template = fspecial('gaussian',[2*r+1,2*r+1],0.8);       % ����ƽ��ƽ��ģ��
 	img1 = imfilter(imraw,template,'replicate');          % ����ʱ�ı߽紦��
    subplot(3,4,2*i-1);imshow(img1);
    subplot(3,4,2*i);imshow(imraw-img1);
end
figure;
for i = 1:length(num)
    r = num(i);                                % ģ���С
    template = fspecial('gaussian',[2*r+1,2*r+1],0.8);       % ����ƽ��ƽ��ģ��
 	img1 = imfilter(imraw,template,'symmetric');          % ����ʱ�ı߽紦��
    subplot(3,4,2*i-1);imshow(img1);
    subplot(3,4,2*i);imshow(imraw-img1);
end
figure;
for i = 1:length(num)
    r = num(i);                                % ģ���С
    template = fspecial('gaussian',[2*r+1,2*r+1],0.8);       % ����ƽ��ƽ��ģ��
 	img1 = imfilter(imraw,template,'circular');          % ����ʱ�ı߽紦��
    subplot(3,4,2*i-1);imshow(img1);
    subplot(3,4,2*i);imshow(imraw-img1);
end

