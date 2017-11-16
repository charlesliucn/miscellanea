clear all,close all,clc;

load hall.mat;                      %��hall.mat�л�ȡ����(hall_color)
hallc=hall_color;                   %����ͼ��Ϊhall.mat�еĲ�ɫͼ��hall_color
                                    %���Ϊhallc,�������ԭʼ����hall_color
imshow(hallc);                      %չʾԭͼ
imwrite(hallc,'./chapter1_2/0hall_origin.bmp');	%���Ϊhall_origin.bmp����ͼ������

[len,width,n]=size(hallc);          %��ȡͼ��ĳ���
radius=min(len,width)/2;            %���Ϳ��н�СֵΪ�뾶
center_x=len/2;                     %�м��ĺ�����
center_y=width/2;                   %�м���������
for i=1:len
    for j=1:width
        dis_sq=(i-center_x)^2+(j-center_y)^2;   %����(i,j)�����ĵ�����ƽ��
        if(dis_sq<=radius^2)        %�жϵ�(i, j)����Բ��
            hallc(i,j,1)=255;       %��Բ�ڵ�ÿһ���ص���Ϊ��ɫ
            hallc(i,j,2)=0;         %(R,G,B)=(255,0,0)
            hallc(i,j,3)=0;
        end
    end
end

figure;
imshow(hallc);                      %չʾ�޸ĺ�ͼ��
imwrite(hallc,'./chapter1_2/1hall_circle.bmp');    %���Ϊhall_circle.bmp,��ͼ������