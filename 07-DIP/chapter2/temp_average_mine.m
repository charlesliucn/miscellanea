clear all;close all;clc;

%% ׼������
imraw = imread('test.jpg');     % ��ȡͼƬ�ļ�
im = mat2gray(imraw);           % תΪ�Ҷ�ͼ
im = im(:,:,1);                 % ����ά��Ϊ1
figure(1);imshow(im);           % չʾԭʼͼƬ
[nrow,ncol,~] = size(im);       % ��ȡͼƬ��С
im_new = zeros(size(im));       % ��ʼ�����ͼ��

%% ���ģ��(fspecialΪģ�����ú�����avearge��ʾƽ��ƽ���˲�)
r = 1;                          % ģ���С
template = fspecial('gaussian',[2*r+1,2*r+1]); 	% ����ƽ��ƽ��ģ��

%% ͼ��߽�Ĵ���
im_conv = zeros(nrow + 2*r,ncol + 2*r);                     % ��ʼ�����б߽��ͼ�����
im_conv(r+1:nrow+r,r+1:ncol+r) = im;                        % ԭʼͼ�񲿷�
im_conv(1:r,:) = im_conv(r+1:r+r,:);                        % �ϱ߽紦��
im_conv(nrow+r+1:nrow+2*r,:) = im_conv(nrow+1:nrow+r,:);    % �±߽紦��
im_conv(:,1:r) = im_conv(:,r+1:r+r);                        % ��߽紦��
im_conv(:,nrow+r+1:nrow+2*r) = im_conv(:,nrow+1:nrow+r);    % �ұ߽紦��

%% ����ģ�������������ƽ���˲�
for i = r+1:nrow+r
    for j = r+1:ncol+r
        im_new(i-r,j-r) = sum(sum(im_conv(i-r:i+r,j-r:j+r).*template))/sum(sum(template));
    end
end

%% չʾ�˲�����
imnew = mat2gray(im_new);   % ��ʽת��
imnew = imnew(:,:,1);       % �Ҷ�ͼ��
figure(2);imshow(imnew);    % չʾ����ƽ���˲����ͼƬ
figure(3);imshow(im - imnew)% չʾ�˲�ǰ��ͼƬ�Ĳ���
