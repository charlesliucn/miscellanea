clear all;close all;clc;

%load('impurity.mat');           % ����ѵ������������
load('tabacoo.mat');            % ����ѵ�����̲�����
pos_sample = tabacoo;           % ������(�̲�)
%neg_sample = impurity;          % ������(����)
pos_num = length(pos_sample);   
%neg_num = length(neg_sample);
pos_feat = zeros(pos_num,3);    % ������������R��G��B����ά

for i = 1:pos_num               % ÿ��������Ӧ����ά�ȵ�����
    r = pos_sample{i}(:,:,1);   
    pos_feat(i,1) = mean(mean(r(r~=0),2));  % �õ�R����
    g = pos_sample{i}(:,:,2);
    pos_feat(i,2) = mean(mean(g(g~=0),2));  % �õ�G����
    b = pos_sample{i}(:,:,3);
    pos_feat(i,3) = mean(mean(b(b~=0),2));  % �õ�B����
end
subplot(3,1,1);hist(pos_feat(:,1),100);title('R����');xlabel('R��ֵ');ylabel('Ƶ��');
subplot(3,1,2);hist(pos_feat(:,2),100);title('G����');xlabel('G��ֵ');ylabel('Ƶ��');
subplot(3,1,3);hist(pos_feat(:,3),100);title('B����');xlabel('B��ֵ');ylabel('Ƶ��');