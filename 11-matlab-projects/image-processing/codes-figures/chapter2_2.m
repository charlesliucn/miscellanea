clear all,close all,clc;

load hall.mat;                      %��hall.mat�л�ȡ����(hall_gray)
hallg=hall_gray;                    %����ͼ��Ϊhall.mat�еĻҶ�ͼ��hall_gray
                                    %���Ϊhallg,�������ԭʼ����hall_gray
hallp=double(hallg(21:60,31:70));   %�ӻҶ�ͼ��ѡȡ40*40һ����hallp,ע�����ͱ仯
DCT1=dct2(hallp);                   %��д��άDCT����mydct2
DCT2=mydct2(hallp);                 %MATLAB�Դ�dct2

diffmax=max(max(abs(DCT1-DCT2)))    %��д��άDCT����mydct2��MATLAB�Դ�dct2�Ա�
Corr=corr2(dct2(hallp),mydct2(hallp))  %�����������ý�������ϵ��(�ȽϽ���Ƿ�һ��) 
