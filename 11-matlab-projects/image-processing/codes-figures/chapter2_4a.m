clear all,close all,clc;
%DCTϵ���������ת�ò���(ѡȡ35*35һС��)
load hall.mat;                      %��hall.mat�л�ȡ����(hall_gray)
hallg=hall_gray;                    %����ͼ��Ϊhall.mat�еĻҶ�ͼ��hall_gray
                                    %���Ϊhallg,�������ԭʼ����hall_gray
hallp=hallg(26:60,66:100);         %ѡȡԭͼ��һ����
subplot(1,2,1);                     %��ͼ1
imshow(hallp);                      %�۲�DCTϵ�����󲻱�ʱ������ͼ��

DCT=dct2(hallp);                    %��hallp������ɢ���ұ任
DCT=DCT';                           %��DCTϵ���������ת�ò���
iDCT=idct2(DCT);                    %����ɢ������任
subplot(1,2,2);                     %��ͼ2
imshow(uint8(iDCT));             	%�۲�DCTϵ������ı������ͼ��
                                    %ע������ֵ��uint8���ͱ�ʾ�����븡�����������ֵҪת��Ϊunit8����
imwrite(uint8(iDCT),'./chapter2_3and4_35��35/4ת��_35��35.bmp'); 