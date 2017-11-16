clear all,close all,clc;

load hall.mat;               	%��hall.mat�л�ȡ����(hall_color)
hallc=hall_color;            	%����ͼ��Ϊhall.mat�еĲ�ɫͼ��hall_color
                              	%���Ϊhallc,�������ԭʼ����hall_color
[len,width,n]=size(hallc);   	%��ȡͼ��ĳ���
slen=len/8;                 	%������������Ϊ8*8
                                %slen��ʾÿһС��ĳ���
swidth=width/8;               	%swidth��ʾÿһС��Ŀ��
for i=1:8
    for j=1:8               
        if(mod((i+j),2)==1)   	%8*8�����̣�����������ĳһ��(i,j)����i+jΪ�������Ǻ�ɫ
                             	%i+jΪż����Ϊ��ɫ������ԭͼ���ʲ�������
                             	%��ɫ(R,G,B)=(0,0,0)
            hallc((i-1)*slen+1:i*slen,(j-1)*swidth+1:j*swidth,1)=0;
            hallc((i-1)*slen+1:i*slen,(j-1)*swidth+1:j*swidth,2)=0;
            hallc((i-1)*slen+1:i*slen,(j-1)*swidth+1:j*swidth,3)=0;
        end
    end
end
imshow(hallc);                     %չʾ�޸ĺ�ͼƬ
imwrite(hallc,'./chapter1_2/3hall_chess.bmp');      %���Ϊhall_chess.bmp,��ͼ������

