clear all,close all,clc;

load hall.mat;                  %��ȡhall.mat��hall_gray������
hallg=double(hall_gray);        %uint8��double������ת��

%����Ϣ���п�������
info='Hello World';             %��Ҫ���ص���Ϣ(�ַ���)
info_bin=dec2bin(double(info)); %���ַ���ת��Ϊchar�ͣ��洢������
[height,width]=size(info_bin);  %��ȡinfo_bin�Ŀ�ߣ���ʵ��height����������Ϣ���ַ����ĳ���
len=height*width;               %��ȡ�������ַ����ĳ���
info_bit=[];                    %�����������ʼ��
for i=1:height  
    for j=1:width
    info_bit=[info_bit str2num(info_bin(i,j))];    
    end                        	%�õ�info_bit���飬�洢����Ҫ���ص��ַ����Ķ�����������ʽ
end
for i=1:len                     %���ص�ͼ���У�����Ϣλ��һ�滻ͼ������ص�ĻҶ����λ
    bit=deci2bin(hallg(i));  	%��ȡͼ�����ص�ĻҶ�ֵ����ת��Ϊ����������
    bit(end)=info_bit(i);       %�������ص�Ҷȵ����λ�滻Ϊ��Ӧ��ŵ���Ҫ���ص���Ϣλ
    hallg(i)=bin2deci(bit);     %�ٽ��ı������ػҶ�ת����ʮ��������ʽ
end
%imshow(uint8(hallg));          %�鿴����������Ϣ֮���ͼ��

%��ȡ���ص���Ϣ
for i=1:len                     %lenΪ������Ϣ���ַ�������
    bit=deci2bin(hallg(i));     %�Ըó��ȷ�Χ�ڵ�ÿһ���ص�ĻҶ�ֵ���д���
    exc(i)=bit(end);            %��ȡ��ÿ���Ҷ�ֵ�����λ
end
exc=reshape(exc,width,height);  %�ı����ĳ���
info_exc=[];                    %��ȡ������Ϣ ��ʼ��
for i=1:height                  %��ȡ���ص��ַ�����ÿһ���ַ���ASIIֵ
    info_exc=[info_exc uint8(bin2deci(exc(:,i)))];  
end                             %����ת��Ϊuint8����
info_exc=char(info_exc)         %��ASCII����ת��Ϊ�ַ���