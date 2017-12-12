clear all;close all;clc;
%% �������8С�⣺ͼ��ˮӡ
% by ��47 ��ǰ 2014011216

%% ����ͼ��׼������
carrier = imread('Girl.bmp');   % ����ͼ��
hidden = imread('Couple.bmp');  % ����ͼ��
[height,width] = size(carrier); % ��ȡͼ����Ϣ
PixelNum = height*width;        % ���ص�����
% չʾԭʼͼ��
subplot(2,2,1);
imshow(carrier);title('����ͼ��Girl.bmpԭʼͼ��');
subplot(2,2,2);
imshow(hidden);title('����ͼ��Couple.bmpԭʼͼ��');

%% 1.�����������
alpha = 0.7;                    % ��ϲ���
carrier = double(carrier);      % ת��double�����ݽ������ش���
hidden = double(hidden);        % ת��double�����ݽ������ش���
mix1 = alpha*carrier + (1 - alpha)*hidden;    	% ��Ϻ�ͼ��
subplot(2,2,3);                 % չʾ���ͼ����
imshow(uint8(mix1));title('���ͼ��');

mix1 = double(uint8(mix1));
hidden_rec1 = (mix1 - alpha*carrier)/(1-alpha);	% �ָ�����ͼ��
subplot(2,2,4);                 % չʾ�ָ�ͼ����
imshow(uint8(hidden_rec1));title('�ָ�ͼ��');
% ����������
RMSE1 = sqrt(sum(sum((hidden_rec1 - hidden).^2))/PixelNum);

%% ��ε���
% 2��
mix1 = alpha*carrier + (1 - alpha)*hidden;    	% ��Ϻ�ͼ��
mix2 = alpha*carrier + (1 - alpha)*mix1;    	% ��Ϻ�ͼ��
mix2 = double(uint8(mix2));
hidden_rec2 = (mix2 - alpha*carrier)/(1-alpha);	% �ָ�����ͼ��
hidden_rec2 = (hidden_rec2 - alpha*carrier)/(1-alpha);	% �ָ�����ͼ��
RMSE2 = sqrt(sum(sum((hidden_rec2 - hidden).^2))/PixelNum);

% 3��
mix2 = alpha*carrier + (1 - alpha)*mix1;    	% ��Ϻ�ͼ��
mix3 = alpha*carrier + (1 - alpha)*mix2;    	% ��Ϻ�ͼ��
mix3 = double(uint8(mix3));
hidden_rec3 = (mix3 - alpha*carrier)/(1-alpha);	% �ָ�����ͼ��
hidden_rec3 = (hidden_rec3 - alpha*carrier)/(1-alpha);	% �ָ�����ͼ��
hidden_rec3 = (hidden_rec3 - alpha*carrier)/(1-alpha);	% �ָ�����ͼ��
RMSE3 = sqrt(sum(sum((hidden_rec3 - hidden).^2))/PixelNum);

figure;
subplot(2,3,1);imshow(uint8(mix1));title('����1��--���ͼ��');
subplot(2,3,2);imshow(uint8(mix2));title('����2��--���ͼ��');
subplot(2,3,3);imshow(uint8(mix3));title('����3��--���ͼ��');
subplot(2,3,4);imshow(uint8(hidden_rec1));title('����1��--�ָ�ͼ��');
subplot(2,3,5);imshow(uint8(hidden_rec2));title('����2��--�ָ�ͼ��');
subplot(2,3,6);imshow(uint8(hidden_rec3));title('����3��--�ָ�ͼ��');
%% 2.���ͼ�������Ͳ����Ĺ�ϵ
RMSE_carrier = [];              % ��ʼ������ͼ��RMSE
RMSE_hidden = [];               % ��ʼ������ͼ��ָ���RMSE
index = 0:0.001:1.0; 
% ��0.1Ϊ��������㲻ͬ��ֵ��Ӧ�ľ��������
for alpha = 0:0.001:1.0
    mix = alpha*carrier + (1 - alpha)*hidden;        % ���ͼ��
    mix = double(uint8(mix));
    RMSE_carrier = [RMSE_carrier,sqrt(sum(sum((mix - carrier).^2))/PixelNum)];      % ����ͼ����������
    mix = alpha*carrier + (1 - alpha)*hidden;        % ���ͼ��
    mix = double(uint8(mix));
    hidden_rec = (mix - alpha*carrier)/(1-alpha);    % �ָ�������ͼ��
    RMSE_hidden = [RMSE_hidden,sqrt(sum(sum((hidden_rec - hidden).^2))/PixelNum)];  % �ָ�ͼ����������
end
% ��ͼ
figure;
subplot(1,2,1);plot(index,RMSE_carrier);title('���ͼ���������� v.s. ��');xlabel('��ϲ�����');ylabel('RMSE');
subplot(1,2,2);plot(index,RMSE_hidden);title('�ָ�ͼ���������� v.s. ��');xlabel('��ϲ�����');ylabel('RMSE');
figure;plot(index,RMSE_carrier+RMSE_hidden);title('���ͼ����ָ�ͼ����������� v.s. ��');xlabel('��ϲ�����');ylabel('RMSE');