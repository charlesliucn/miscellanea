function [impurity,tabacoo] = extraction(img_raw,img_marked,type)
% �������ܣ����Ѿ���ǳ����ʵ��̲�ͼ��ѵ����������ȡ������ͼ��(���̲������ʷ���)
% ����˵����
%   ���룺
%       img_raw��        ԭʼͼ�����
%       img_marked��     ��ǳ����ʵ�ͼ�����
%       type��           �̲�ͼ������
%               in44**.bmp          type = 1
%           	20161121-**.bmp     type = 2
%
%   �����
%       impurity��       Ԫ�����飬�洢����ȡ��������ͼ��
%       tabacoo��        ��ȡ������֮��ʣ�µ��̲�ͼ��
%  Copyright (c) 2017, Liu Qian All rights reserved. 

%% ׼������
[height,width,~] = size(img_raw);   %��ȡͼ���С��Ϣ
maximum = height * width;           %���ص�����
img_dif = img_marked - img_raw;     %��ǵ�ͼ����ԭʼͼ��Ĳ�����������ʺ��̲ݵķ���
img_refer = img_dif(:,:,type);      %RGB��ά��ѡȡ����һά�����ں�ɫ���ǵ����ʣ�ѡȡR����type = 1;��ɫ���ǵ�type = 2
index = find(img_refer ~= 0)';      %�ҵ��߿�
pos = [];                           %pos���ڴ洢ÿ������ͼ��������Ͻǵ����ص��λ��

%% Ѱ�����ʵ�λ��
for i = index(index <= maximum - height - 1)
    if ( img_refer(i) ~= 0 && img_refer(i-height) ~= 0 && img_refer(i+1) ~=0 && img_refer(i-1) ~=0 && img_refer(i + height) ~= 0 ...
         && img_refer(i + height + 1) == 0) && img_refer(i-4*height-4) ~=0 && img_refer(i-4*height-5) == 0 && img_refer(i-5*height-4) ==0 ...
         && img_refer(i-4*height-3) ~= 0 && img_refer(i-3*height-4) ~= 0  %�ܳ����ж�����
    pos = [pos,i];                  %�洢�ҵ���λ��
    end
end
pos = pos + height + 1;             %�����Ľ��ʵ���ϲ������ʵ������Ͻǵ�����
%% ��ʼ��
block_num = length(pos);            %����ͼ�����Ŀ
blockh = zeros(1,block_num);    blockw = zeros(1,block_num);
pos_x = zeros(1,block_num);     pos_y = zeros(1,block_num);
impurity = cell(1,block_num);       %��ʼ��Ԫ�����飬���ڴ洢����ͼ��

%% ��ÿ������ͼ�������ȡ����ȡ���ԭͼ��ɾ���ò�������
for i = 1:block_num
    pos_x(i) = fix(pos(i)/height)+1;
    pos_y(i) = mod(pos(i),height);
    for j = 1:height
        if (pos_y(i) + j <= height)
            if (img_refer(pos(i) + j) ~= 0)
                if(img_refer(pos(i) + j - height + 5) ~= 0), continue;
                else blockh(i) = j; break;
                end
            end
        else blockh(i) = height - pos_y(i) + 1;
        end
    end
    for j = 1:width
        if (pos_x(i) + j <= width)
            if(img_refer(pos(i) + j*height) ~=0)
                if(img_refer(pos(i) + j*height + 5*height - 1) ~= 0),continue;
                else blockw(i) = j; break;
                end
            end
        else blockw(i) = width - pos_x(i) + 1;
        end
    end
    impurity{i} = img_raw(pos_y(i):pos_y(i)+blockh(i)-1, pos_x(i):pos_x(i)+ blockw(i)-1,:);
    img_raw(pos_y(i):pos_y(i)+blockh(i)-1, pos_x(i):pos_x(i)+ blockw(i)-1,:) = 0;
    tabacoo = img_raw;              %ɾ�����ʺ���̲�ͼ��
end
