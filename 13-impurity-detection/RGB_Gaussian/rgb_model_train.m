function [rgb_mean,rgb_cov] = rgb_model_train()
% �������ܣ��̲�ͼ���RGBֵ�ķֲ����Խ���Ϊ��ά�����ϸ�˹�ֲ���
% �ú������ݲ������������̲�ͼ��RGB�ֲ��ľ�ֵ��Э������������ѵ��
%
% �����
%       rgb_mean����ֵ����
%       rgb_cov ��Э�������
%  Copyright (c) 2017, Liu Qian All rights reserved. 

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
    rgb_mean = mean(pos_feat);                  % ��ֵ����
    rgb_cov = cov(pos_feat);                    % Э�������
    save('rgb_model.mat','rgb_mean','rgb_cov');
end
