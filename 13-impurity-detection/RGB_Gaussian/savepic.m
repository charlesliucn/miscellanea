function [] = savepic(impurity,picnumber)
% �������ܣ�����ͼƬ
%   ���룺
%       impurity�� extraction�������������ͼ��Ԫ������
%       picnumber��ͼ�����(��������ͼ�������)
%  Copyright (c) 2017, Liu Qian All rights reserved. 

    npic = length(impurity);
    for i = 1:npic
         imwrite(impurity{i},sprintf('%d-%d.bmp',picnumber,i));
    %    imwrite(impurity{i},sprintf('./impurity/%d-%d.bmp',picnumber,i));   %�浽��ǰĿ¼��impurity�ļ�����
    end
end