clear all,close all,clc;
%DCTϵ�������Ҳ�4��ȫ������(ѡȡ35*35һС��)
load hall.mat;                      %��hall.mat�л�ȡ����(hall_gray)
hallg=hall_gray;                    %����ͼ��Ϊhall.mat�еĻҶ�ͼ��hall_gray
                                    %���Ϊhallg,�������ԭʼ����hall_gray
hallp=hallg(26:60,66:100);          %ѡȡԭͼ��һ����
subplot(1,2,1);                     %��ͼ1
imshow(hallp);                      %�۲�DCTϵ�����󲻱�ʱ������ͼ��
imwrite(hallp,'./chapter2_3and4_35��35/1ԭͼ_35��35.bmp'); 

DCT=dct2(hallp);                    %��hallp������ɢ���ұ任
DCT(:,37:40)=0;                     %��DCTϵ�������Ҳ�4��ȫ������
iDCT=idct2(DCT);                    %����ɢ������任
subplot(1,2,2);                     %��ͼ2
imshow(uint8(iDCT));             	%�۲�DCTϵ������ı������ͼ��
                                    %ע������ֵ��uint8���ͱ�ʾ�����븡�����������ֵҪת��Ϊunit8����
imwrite(uint8(iDCT),'./chapter2_3and4_35��35/2�Ҳ�4������_35��35.bmp'); 