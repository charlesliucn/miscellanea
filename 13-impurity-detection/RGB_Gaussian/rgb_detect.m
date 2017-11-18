function img_detect = rgb_detect(filename,step,blocksize)
% �������ܣ��������̲�ͼ���ж����ʽ��м�⣺��ͼ��ֳ�С�飬��ÿС���Ƿ�������ʽ��м��
% ���룺
%   filename ��ͼƬ��(�ַ���)
%   step     ���ص����Ĳ���
%   blocksize����ı߳���
%
% �����
%   img_detect������õ���ͼ�񣬶��ж�Ϊ�̲ݵĲ��������˱��
%  Copyright (c) 2017, Liu Qian All rights reserved. 

    img = imread(filename);     % ����ͼ��
    [height,width,~] = size(img);
    
    % ��ͼ���С���д��������ص�ʽ�ر���ͼ��
    extra = blocksize - step;   
    xneed = step - mod(extra,step);
    img_proc = [img,img(:,width-xneed+1:width,:)];              % ˮƽ�����ȵĵ���
    yneed =  step - mod(extra,step);
    img_proc = [img_proc;img_proc(height-yneed+1:height,:,:)];  % ��ֱ���򳤶ȵĵ���

    % �˴�������СС�Ĵ���������������Ϊ�������ͣ�һ���ǽӽ����ε��̲�ͼ��
    % һ����ϸ�����̲�ͼ�񣬿��ǵ���ͬ���ض�����ͼ���Ӱ�죬�ֱ���������͵�
    % ͼ�����ֵ����ѵ�����˴���ֵʹ�õ�������(Mahalanobis)���롣
    if( height > 5000)  % �ж��̲�ͼ������
        threshold = 48; % ��Խ��Ʒ���ͼ�����ֵ
    else threshold = 23;% ���ϸ����ͼ�����ֵ
    end
%     [rgb_mean,rgb_cov] = rgb_model_train();         % ������̲�ͼ��ѵ���Ľ��
    load('rgb_model.mat');
    invcov = inv(rgb_cov);
    for i = 0:step:height-blocksize                 % �ص�ʽ����ͼ�񣬶�ÿ��С����м��
        for j = 0:step:width-blocksize
            sample = img_proc(i+1:i+blocksize,j+1:j+blocksize,:);
            rfeat = mean(mean(sample(:,:,1)));      % R����
            gfeat = mean(mean(sample(:,:,2)));      % G����
            bfeat = mean(mean(sample(:,:,3)));      % B����
            feat = [rfeat,gfeat,bfeat];         
            mahaDist = (feat - rgb_mean)*invcov*(feat - rgb_mean)'; % ���Ͼ�����Ϊ�쳣ֵ��������
            if mahaDist > threshold                 % ���Ͼ������ĳһ��ֵʱ����Ϊ��С���������
                % ����Ӧ��С����б�ע
                img_proc([i+1:i+step],j+1:j+step,1) = 255;
                img_proc([i+1:i+step],j+1:j+step,2) = 255;
                img_proc([i+1:i+step],j+1:j+step,3) = 255;
                img_proc(i+1:i+step,[j+1:j+step],1) = 255;
                img_proc(i+1:i+step,[j+1:j+step],2) = 255;
                img_proc(i+1:i+step,[j+1:j+step],3) = 255;
            end   
        end
    end
    img_detect = img_proc(1:height,1:width,:);              % �Ѿ���ע�����ʵ�ͼ��
    imwrite(img_detect,sprintf('%s-detect.bmp',filename));  % д��ͼƬ�ļ�
end
