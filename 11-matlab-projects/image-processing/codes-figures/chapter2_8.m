clear all,close all,clc;

load hall.mat;                  %��ȡhall.mat����
load JpegCoeff.mat;             %��ȡJpegCoeff.mat����

%����ǰ׼��
[leny,lenx]=size(hall_gray);    %��ȡhall_gray��С
hallg=hall_gray;                %����ͼ��Ϊhall.mat�еĻҶ�ͼ��hall_gray
                             	%���Ϊhallg,�������ԭʼ����hall_gray
XNum=ceil(lenx/8);             	%ˮƽ����ÿ8������,����8�ı����貹ȫ
YNum=ceil(leny/8);             	%��ֱ����ÿ8������,����8�ı����貹ȫ
Total_Num=XNum*YNum;            %8*8Ϊ1�飬Total_Num�����ܸ���
index_y=8*ones(1,YNum);         %cell��Ԫ����ÿ������Ԫ�ص���ֱ�߶���ȣ���Ϊ8
index_x=8*ones(1,XNum);         %cell��Ԫ����ÿ������Ԫ�ص�ˮƽ������ȣ���Ϊ8

%�ֿ�
Cell=mat2cell(hallg,index_y,index_x);  	%��ÿ��8*8�Ŀ鵱��1��cell��ԪԪ��
QC=zeros(8*8,Total_Num);                %��ÿ������������Zig-Zagɨ��֮���ϵ������

%���ٻҶȡ�DCT������Zig-Zagɨ��
for i=1:YNum                            %���ζ�ÿ��8*8С����д���
    for j=1:XNum
    Cell{i,j}=double(Cell{i,j})-128;        %��ÿС��ͼ�����Ԥ��������ÿ�����ػҶȼ�ȥ128,ע������ת������
    Cell_DCT=dct2(Cell{i,j});               %DCT����ɢ���ұ任���õ���άDCTϵ������
    Cell_QT=round(Cell_DCT./QTAB);          %��������
    QC(:,(i-1)*XNum+j)=zigzag2(Cell_QT); 	%��ÿС���DCTϵ������ɨ��õ�һ����ʸ����������ʸ�����ɾ���
    end
end
DC=QC(1,:);         %��һ��Ԫ��Ϊ�������DCϵ��         