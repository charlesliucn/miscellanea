function [deci] = bin2deci(bin)
% �������ܣ�����������ת��Ϊʮ����
% ��MATLAB�����bin2dec��ͬ������ֵ�����ַ�������ʮ��������
% ����bit��1����ֱ�ӷ���ʮ���ƣ����򣬱�ʾ1�����Ӧ������������λȡ���õ�ʮ���ƣ�����Ӹ��ŷ��ظ�����
% ���룺   ����������
% ����ֵ�� ʮ��������
    bitnum=length(bin);
    deci=0;
    if bin(1)==1
        for i=1:bitnum
            deci=deci+2^(bitnum-i)*bin(i);
        end
    else
        bin=~bin;
         for i=1:bitnum
            deci=deci+2^(bitnum-i)*bin(i);
         end
        deci=-deci;
    end
end
            
            

