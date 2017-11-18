function [img_comp] = rgb_compare(rawname,detname,markedname,type)
% �������ܣ�ʹ��RGBģ�ͼ����̲�ͼ��������ʵ�����ʽ����ͬһ��ͼ���н��жԱ�
% ���룺
%   rawname   ��ԭʼ������̲�ͼ���ļ���
%   detname   ��RGB���֮��Ľ��ͼ���ļ���
%   markedname����ȷ��ǳ����ʵ�ͼ���ļ���
%   type      ����ȷ��ǳ����ʵ�ͼ�������ڿ�����ʵ���ɫ
%       type = 1,����ʹ�õ��Ǻ�ɫ
%       type = 2,����ʹ�õ�����ɫ
%       type = 3,����ʹ�õ�����ɫ
%  Copyright (c) 2017, Liu Qian All rights reserved. 

%% ��������ͼ��
    img_raw = imread(rawname);
    img_detect = imread(detname);
	img_real = imread(markedname);

%% ��ʼ���ȽϺ��ͼ��
    img_compr = img_detect(:,:,1);
    img_compg = img_detect(:,:,2);
    img_compb = img_detect(:,:,3);   
    img_comp = img_detect;
    
%% ��detectͼ�����ҵ������ڵ�λ��
    img_dif = img_real - img_raw;
    img_dif = img_dif(:,:,type);  % ��RGB����һ����Ϊ����
    img_dif = find(img_dif ~=0);  
    % ȫ��ͳһ�ú�ɫ���
    img_compr(img_dif) = 255;
    img_compg(img_dif) = 0;
    img_compb(img_dif) = 0;

    img_comp(:,:,1) = img_compr;
    img_comp(:,:,2) = img_compg;
    img_comp(:,:,3) = img_compb;
    % �����д���ļ�
    imwrite(img_comp,sprintf('%s-compare.bmp',rawname));
    
end


