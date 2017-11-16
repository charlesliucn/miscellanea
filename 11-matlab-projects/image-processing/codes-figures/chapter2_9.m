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
    QC(:,(i-1)*XNum+j)=zigzag1(Cell_QT); 	%��ÿС���DCTϵ������ɨ��õ�һ����ʸ����������ʸ�����ɾ���
    end
end

%---------------DCϵ������--------------%
Err=QC(1,:);                            %����ֱ������Ԥ�����ʸ��
Category=zeros(1,Total_Num);          	%Category����
Category(1)=ceil(log2(abs(Err(1))+1));  %�Ե�һ��Ԥ�������е�������      
Magnitude=deci2bin(Err(1));             %Magnitude��Ԥ�����Ķ����Ʊ�ʾ����������1�����ʾ
                                        %deci2bin��ר��Ϊ����д�ĺ��������deci2bin.m    
DCCode=[DCTAB(Category(1)+1,2:1+DCTAB(Category(1)+1,1)) Magnitude];     %��һ��Ԥ�����ı���
for i=2:Total_Num                           %�ӵ�2��DCϵ����ʼ���ν��д���
    Err(i)=QC(1,i-1)-QC(1,i);               %Ԥ�����ļ���
    Category(i)=ceil(log2(abs(Err(i))+1));  %Category�����ļ���
    Magnitude=deci2bin(Err(i));             %Magnitude��Ԥ�����Ķ����Ʊ�ʾ
    DCCode=[DCCode DCTAB(Category(i)+1,2:1+DCTAB(Category(i)+1,1)) Magnitude];
                                            %��ÿ��DCϵ���ı��벢��DCCodeʸ����
                                            %����Category��Magnitude������
end

%-----------ACϵ������------------%
ACCode=[];                          %ACCode��ʼ��Ϊ�վ���
ZRL=[1,1,1,1,1,1,1,1,0,0,1];        %����16��0�������ZRL��(F/0)����Ϊ11111111001
EOB=[1,0,1,0];                      %�������һ������ACϵ��������������EOB��(0/0)����Ϊ1010
for i=1:Total_Num                   %��ɨ������õ�QC�������н��д���
    Run=0;                          %�г�Run��ʼ��
    AC=QC(2:end,i);                 %ÿ�еĵ�һ��Ԫ��ΪDCϵ����ʣ��Ԫ��ΪACϵ��
    last_nonz=find(AC~=0,1,'last'); %���ҵ����һ������ϵ����֮��Ԫ�ؾ�Ϊ0Ԫ��
    if ~isempty(last_nonz)              %last_nonz����Ϊ�վ��󣨵�ACȫΪ0ʱ��
        for j=1:last_nonz               %��ACϵ�������ĵ�һ��һֱ��֮ǰ���õ����һ������ϵ��
            if AC(j)==0                 %ÿ����Ԫ��
                if Run<15               %�ж��Ƿ�����16����
                    Run=Run+1;          %δ������16����ʱ��ÿ����Ԫ�أ��г̼�1
                else
                    ACCode=[ACCode ZRL];%����16���㣬�����ZRL
                    Run=0;              %���ҽ�Run��������
                end
            else                        %��ACϵ���Ƿ���Ԫ��ʱ
                Size=ceil(log2(abs(AC(j))+1));	%Size�ļ���/��Catagory��ͬ
                Amplitude=deci2bin(AC(j));     	%Amplitude�ļ���/��Magnitude��ͬ
                L=ACTAB(10*Run+Size,3);        	%��ȡAC����ĳ���
                ACCode=[ACCode ACTAB(10*Run+Size,4:3+L) Amplitude]; 
                                                %�õ��÷���Ԫ�صı���
                                                %����(Run/Size)�������Huffman�����Amplitude
                Run=0;                         	%��Run��������
            end
        end
    end
    ACCode=[ACCode EOB];                        %ÿһ�д����궼Ҫ��EOB�����飺ÿһ����󶼻���������
end 

%ͼ��ߴ�
Height=leny;        %ͼ��߶�
Width=lenx;         %ͼ����

%���ΪDCϵ����������ACϵ����������ͼ��ĸ߶ȺͿ�ȣ����ĸ�����д��jepgcodes.mat�ļ�
save('jpegcodes.mat','DCCode','ACCode','Height','Width');
