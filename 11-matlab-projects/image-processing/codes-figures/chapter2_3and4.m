clear all,close all,clc;
%�����в���Ӧ����������ԭͼ�������ԱȽ�
load hall.mat;                  	%��hall.mat�л�ȡ����(hall_gray)
hallg=hall_gray;                    %����ͼ��Ϊhall.mat�еĻҶ�ͼ��hall_gray
                                    %���Ϊhallg,�������ԭʼ����hall_gray
subplot(2,3,1);                     %��ͼ1
imshow(hallg);                      %�۲�DCTϵ�����󲻱�ʱ������ͼ��
title('ԭͼ','FontSize',8);         %����
imwrite(hallg,'./chapter2_3and4/1ԭͼ.bmp');  %�����ͼƬ��������

%DCTϵ�������Ҳ�4��ȫ������
DCT1=dct2(hallg);                 	%��hallp������ɢ���ұ任
DCT1(:,37:40)=0;                 	%��DCTϵ�������Ҳ�4��ȫ������
iDCT1=idct2(DCT1);               	%����ɢ������任
subplot(2,3,2);                     %��ͼ2
imshow(uint8(iDCT1));             	%�۲�DCTϵ������ı������ͼ��
                                    %ע������ֵ��uint8���ͱ�ʾ�����븡�����������ֵҪת��Ϊunit8����
title('DCTϵ����4������','FontSize',8);   %����
imwrite(uint8(iDCT1),'./chapter2_3and4/2��4��ȫ������.bmp');      %�����ͼƬ��������

%DCTϵ���������4��ȫ������
DCT2=dct2(hallg);                 	%��hallg������ɢ���ұ任
DCT2(:,1:4)=0;                     	%��DCTϵ���������4��ȫ������
iDCT2=idct2(DCT2);               	%����ɢ������任
subplot(2,3,3);                     %��ͼ2
imshow(uint8(iDCT2));             	%�۲�DCTϵ������ı������ͼ��
                                    %ע������ֵ��uint8���ͱ�ʾ�����븡�����������ֵҪת��Ϊunit8����
title('DCTϵ����4������','FontSize',8);   %����
imwrite(uint8(iDCT2),'./chapter2_3and4/3��4��ȫ������.bmp');      %�����ͼƬ��������

%DCTϵ���������ת�ò���
DCT3=dct2(hallg);                	%��hallp������ɢ���ұ任
DCT3=DCT3';                      	%��DCTϵ���������ת�ò���
iDCT3=idct2(DCT3);               	%����ɢ������任
subplot(2,3,4);                     %��ͼ2
imshow(uint8(iDCT3));             	%�۲�DCTϵ������ı������ͼ��
                                    %ע������ֵ��uint8���ͱ�ʾ�����븡�����������ֵҪת��Ϊunit8����
title('DCTϵ������ת��','FontSize',8);    %����
imwrite(uint8(iDCT3),'./chapter2_3and4/4ת��.bmp');               %�����ͼƬ��������

%DCTϵ��������ת90��
DCT4=dct2(hallg);                 	%��hallp������ɢ���ұ任
DCT4=rot90(DCT4);                  	%��DCTϵ��������ת90��
iDCT4=idct2(DCT4);               	%����ɢ������任
subplot(2,3,5);                     %��ͼ2
imshow(uint8(iDCT4));             	%�۲�DCTϵ������ı������ͼ��
                                    %ע������ֵ��uint8���ͱ�ʾ�����븡�����������ֵҪת��Ϊunit8����
title('DCTϵ��������ת90��(��)','FontSize',8);  %����
imwrite(uint8(iDCT4),'./chapter2_3and4/5��ʱ����ת90��.bmp');     %�����ͼƬ��������

%DCTϵ��������ת180��                         
DCT5=dct2(hallg);                	%��hallp������ɢ���ұ任
DCT5=rot90(DCT5);                  	%��DCTϵ��������ת90��
DCT5=rot90(DCT5);                  	%��DCTϵ����������ת90�ȣ�����ת180�ȣ�
iDCT5=idct2(DCT5);                  %����ɢ������任
subplot(2,3,6);                     %��ͼ2
imshow(uint8(iDCT5));             	%�۲�DCTϵ������ı������ͼ��
                                    %ע������ֵ��uint8���ͱ�ʾ�����븡�����������ֵҪת��Ϊunit8����
                                   	%ע������ֵ��uint8���ͱ�ʾ�����븡�����������ֵҪת��Ϊunit8����
title('DCTϵ��������ת180��','FontSize',8);    %����
imwrite(uint8(iDCT5),'./chapter2_3and4/6��ת180��.bmp');         %�����ͼƬ��������  
