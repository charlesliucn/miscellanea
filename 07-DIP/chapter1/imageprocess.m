clear all;close all;clc;
warning('off');
%% ��ȡͼƬԤ����
mat1 = imread('test4.jpg');
M1 = rgb2gray(mat1);
M2 = imnoise(M1,'gaussian');
% M1 = mat1(300:640,300:640,1);
% M2 = mat2(300:640,300:640,1);
figure(1);imshow(M1);
figure(2);imshow(M2);

%% ͼ�������
% �ӷ�����
plus = M1 + M2;
figure(3);imshow(plus);

% ��������
minus = M1 - M2;
figure(4);imshow(minus);

% �˷�����
times = M1 .* M2;
figure(5);imshow(times);

% ��������
division = M1 ./ M2;
figure(6);imshow(division);

% ��;��
not = bitcmp(M1);
figure(7);imshow(not);

% ��
andd = bitand(M1,M2);
figure(8);imshow(andd);

% ��
orr = bitor(M1,M2);
figure(9);imshow(orr);

% ���
xorr = bitxor(M1,M2);
figure(10);imshow(xorr);

%% ͼ��Ҷ�ӳ��
M1a = (M1/255).*M1;
figure(11);imshow(M1a);

M1b = 255 - M1;
figure(12);imshow(M1b);

M1c = enhance(M1);
figure(13);imshow(M1c);

M1d = dynarange(M1);
figure(14);imshow(M1d);

%% ֱ��ͼ
% ֱ��ͼ���⻯
hist1 = histeq(M1);
figure(15); imshow(hist1);

% ֱ��ͼ�涨��
hist1 = hist1/2;
match = imhist(hist1);
Mout = histeq(M1,match);
figure(16);imshow(Mout);

% ֱ��ͼ�Ƚ�
figure(17);
subplot(1,3,1);imhist(M1,64);
subplot(1,3,2);imhist(hist1,64);
subplot(1,3,3);imhist(Mout,64);
S = sum(hist1 - Mout);