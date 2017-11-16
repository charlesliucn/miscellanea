function [bin] = deci2bin(deci)
% �������ܣ���ʮ������ת��Ϊ������
% ��MATLAB�����dec2bin��ͬ������ֵ�����ַ���������������
% �Ǹ��������ض����ƣ�ԭ�룩������������1����
% ���룺   һ��ʮ������
% ����ֵ�� ʮ�������Ķ�������ʽ��������洢
    if deci==0
        bin=[0];
    else
        bitnum=ceil(log2(abs(deci)+1));
        bin=zeros(1,bitnum);
        bin_str=dec2bin(abs(deci));
        for i=1:bitnum
            bin(i)=str2num(bin_str(i));
        end
        if(deci<0)
            bin=~bin;
        end
end

