clear all,close all,clc;

FaceNum=33;
L=3;
colornum=2^(3*L);
v_sum=zeros(1,colornum);
 for i=1:FaceNum
    filename=sprintf('%i.bmp',i);   %��ͼ���ļ���
    Face=imread(filename);        	%��ȡͼƬ
    u=ColorExc(L,Face);
    v_sum=v_sum+u;
 end
 v1=v_sum/FaceNum;
 save('v1.mat','v1');