clear all,close all,clc;

load hall.mat;                      %��hall.mat�л�ȡ����(hall_gray)
hallg=hall_gray;                    %����ͼ��Ϊhall.mat�еĻҶ�ͼ��hall_gray
                                    %���Ϊhallg,�������ԭʼ����hall_gray
hallp=double(hallg(21:60,31:70));   %�ӻҶ�ͼ��ѡȡ40*40һ����hallp,ע�����ͱ仯
hallp_sub=hallp-128*ones(40,40);    %��ÿ�����ػҶ�ֵ��ȥ128
subplot(1,2,1);                     %��ͼ1
imshow(hallp_sub);                  %�۲��һ�ַ���������ͼ��
imwrite(hallp_sub,'./chapter2_1/1��ȥ128.bmp');    %���Ϊ��1��ȥ128.bmp��,��ͼ������

%�����ڱ任���н���
DCTa=dct2(hallp);                   %��hallp������ɢ���ұ任
DCTb=dct2(128*ones(40,40));         %��ɢ���ұ任
hallp_trans=idct2(DCTa-DCTb);       %������ɢ������任���õ��任��Ĵ�����hallp_trans
subplot(1,2,2);                     %��ͼ2
imshow(hallp_trans);                %�۲�任������ͼ��
imwrite(hallp_trans,'./chapter2_1/2�任��.bmp');    %���Ϊ��2�任��.bmp��,��ͼ������
diffmax=max(max(abs(hallp_sub-hallp_trans)))     %���ִ���������ͼ������Ԫ��֮������ֵ
Cor=corr2(hallp_sub,hallp_trans)                 %���ִ���������ͼ���������ϵ��(�Ƚ����ƶ�)

