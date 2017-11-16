clear all,close all,clc;
%ѩ��ͼ�����JPEG����봦��
load snow.mat;                  %��ȡsnow.mat����
load JpegCoeff.mat;             %��ȡJpegCoeff.mat����
%QTAB=QTAB/2;                    %������������СΪԭ����һ��

%-------------------------------------------���뿪ʼ---------------------------------------------%
%����ǰ׼��
[leny,lenx]=size(snow);    %��ȡsnow��С
snows=snow;                %����ͼ��Ϊsnow.mat�еĻҶ�ͼ��snow
                             	%���Ϊsnows,�������ԭʼ����snow
XNum=ceil(lenx/8);             	%ˮƽ����ÿ8������,����8�ı����貹ȫ
YNum=ceil(leny/8);             	%��ֱ����ÿ8������,����8�ı����貹ȫ
Total_Num=XNum*YNum;            %8*8Ϊ1�飬Total_Num�����ܸ���
index_y=8*ones(1,YNum);         %cell��Ԫ����ÿ������Ԫ�ص���ֱ�߶���ȣ���Ϊ8
index_x=8*ones(1,XNum);         %cell��Ԫ����ÿ������Ԫ�ص�ˮƽ������ȣ���Ϊ8

%�ֿ�
Cell=mat2cell(snows,index_y,index_x);  	%��ÿ��8*8�Ŀ鵱��1��cell��ԪԪ��
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
%---------------------------------------------�������----------------------------------------%

%---------------------------------------------����ѹ����--------------------------------------%
DCL=length(DCCode);         %DCϵ���������������
ACL=length(ACCode);     	%ACϵ���������������
InputL=Height*Width*8;  	%�����ļ����ȣ�ת��Ϊ�����ƣ�ÿ��������Ҫ8λ
OutputL=DCL+ACL;        	%����������ȣ�����DCϵ������������ACϵ����������
COMR=InputL/OutputL;        %ѹ����=�����ļ�����/�����������
%---------------------------------------------�������----------------------------------------%

%---------------------------------------------���뿪ʼ----------------------------------------%
%DCCode����õ�DCϵ��
ErrDec=[];              %�������õ�Ԥ���������ErrDec��ʼ��
DLTAB=DCTAB(:,1);       %DCϵ��Ԥ�������뱾�б���ĳ���
NumDC=length(DLTAB);    %DCϵ��Ԥ�������뱾��Category����
DCL=length(DCCode);     %DCϵ��Ԥ���������DCCode�������ܳ���
code_start=1;           %����ʱ����ʼ��Huffman���벿�֣���ʹ��code_start��ʾHuffman�����ʼλ
while(code_start<=DCL)  %�жϽ���δ���ʱ
    for CT=1:NumDC      %���뱾��Ѱ��������ƥ���Category����ÿ��Category�Ա�
        code_end=code_start+DLTAB(CT)-1;    %Huffman�����ֹλ���볢��ƥ��ʱ��ѡ��Category�й�
        if (DCTAB(CT,2:DLTAB(CT)+1))==DCCode(code_start:code_end)   %��ȫƥ�䣬�ҵ��뱾�ж�Ӧ����
            Category=CT-1;                  %��ȡCategory
            break;      %�������뱾֮������ݶԱ�
        end
    end
    bit_start=code_end+1;              	%����ÿ���������DCϵ��Ԥ����Huffman��֮��ΪMagnitude����
    if Category==0
        ErrDec=[ErrDec 0];            	%��CategoryΪ0ʱ������������ʱ����Ԥ�����Ϊ0�������0
        code_start=bit_start+1;       	%��һλ����һ��DCԤ������Huffman�����ʼλ
    else
        bit_end=bit_start+Category-1; 	%��������£���Category�����Magnitude����ֹλ
        bits=DCCode(bit_start:bit_end);	%��ʼλ����ֹλ֮��Ĳ�����Ԥ������Ӧ��Magnitude����bits
        ErrDec=[ErrDec bin2deci(bits)];	%����bits�ɺ���bin2cdeci�õ�ʮ������ʽ��Ԥ��������Ԥ���������
        code_start=bit_end+1;         	%��Ԥ����������ϣ�������һԤ������Huffman����ʼλ��
    end
end
DCDec=ErrDec;                     	%׼����Ԥ����������õ�DCϵ��
for i=2:length(ErrDec)
    DCDec(i)=DCDec(i-1)-ErrDec(i); 	%���Ƶõ�DCϵ������DCDec,��Ϊ������DCϵ������
end

%AC����
ZRL=[1,1,1,1,1,1,1,1,0,0,1];	%ZRL�ı��룬��ʾACϵ����16������
EOB=[1,0,1,0];                  %������EOB�ı��룬ACϵ��ÿ63��Ϊһ�飬ÿ���β���н�����
ACDec=[];                    	%�������õ�ACϵ��������ʼ��
ALTAB=ACTAB(:,3);           	%ACϵ���뱾�в�ͬRun/Size���볤L
NumAC=length(ALTAB);          	%ACϵ���뱾�в�ͬRun/Size���ܸ���
ACL=length(ACCode);         	%AC���������ܳ���
zero_dbg=zeros(1,5);           	%�ر�˵�������ڽ���ʱcode_end���ܷ��ʵ�����ACCode���ȵĲ���
                              	%Ϊ�˷�ֹMATLAB���������ӳ�ACCode����,��ʵ�϶Խ��û���κ�Ӱ��
ACCode=[ACCode zero_dbg];     	%�ӳ���õ���ACCode
code_start=1;                 	%����ʱ����ʼ��Huffman���벿�֣���ʹ��code_start��ʾHuffman�����ʼλ
while(code_start<=ACL)          %�жϽ���δ���ʱ,��ACCode�������н���
    if(ACCode(code_start:code_start+3)==EOB)    %��������EOB������
        currL=length(ACDec);                    %��ȡ��ǰ����õ���ACDec�ĳ���
        if(mod(currL,63)==0&&ACDec(end)~=0)     %�����ǰACDec�����Ѿ�Ϊ63�ı����������һλ�Ƿ�����
                                                %��������Ҫ�ٲ���
            code_start=code_start+4;            %ֱ�ӽ�����һ��Huffman��Ľ���,����code_start
        else                                    %���������Ҫ��ACDec���㲹ȫ63λ(ACDec����Ϊ63�ı���)
            zero=zeros(1,63-mod(currL,63));     %���ڲ�ȫ����������63-mod(currL,63)������Ҫ��ĸ���
            ACDec=[ACDec zero];                 %����������ȫ63λ
            code_start=code_start+4;            %����EOB��ϣ�������һ��Huffman��Ľ���,����code_start
        end
    elseif (ACCode(code_start:code_start+10)==ZRL)  %��������ZRL������ACϵ��������������16����
        zero=zeros(1,16);           %16���������
        ACDec=[ACDec zero];         %��������ACDec������16����
        code_start=code_start+11;   %����ZRL��ϣ�������һ��Huffman�Ľ��룬����code_start
    else                            %��ȥEOB��ZRL֮�⣬���������Ҫ�����������ν���
        for k=1:NumAC               %���뱾��Ѱ��������ƥ���Run/Size
            code_end=code_start+ALTAB(k)-1;     %Huffman�����ֹλ�����뱾�ж�Ӧ���볤�й�
            if (ACTAB(k,4:ALTAB(k)+3))==ACCode(code_start:code_end)   %��ȫƥ�䣬�ҵ��뱾�ж�Ӧ����
                Run=ACTAB(k,1);  	%��ȡ�г�Run��������ϵ��֮ǰ��ĸ���
                Size=ACTAB(k,2);    %��ȡSize������ǰACϵ�������Ʊ�ʾʱ�ı�����
                break;
            end
        end
        zero=zeros(1,Run);          %���ɳ��ȵ���Run�������
        ACDec=[ACDec zero];         %��������ACDec�����Ӹþ���
        bit_start=code_end+1;       %��һλ��Ӧ��ACϵ����������ʽ����ʼλ
        bit_end=bit_start+Size-1;   %��Size����õ�ACϵ����������ʽ����ֹλ
        bits=ACCode(bit_start:bit_end);	%��ACCode�����еõ�ACϵ����Ӧ�Ķ�������ʽ
        ACDec=[ACDec bin2deci(bits)]; 	%����bits�ɺ���bin2cdeci�õ�ʮ������ʽ��ACϵ��������ACϵ������
        code_start=bit_end+1;       %��ACϵ��������ϣ�������һϵ����Huffman����ʼλ��  
    end
end
ACcount=length(ACDec);              %��ȡ����õ���ϵ�������ܳ���
ACMat=reshape(ACDec,63,ACcount/63); %������ת��Ϊ63�еľ���
CoMat=[DCDec;ACMat];                %DCϵ����ACϵ���ϲ����ָ��õ�DCTϵ������(Zig-Zag����֮��)
%��������
YNum=Height/8;                      %8*8Ϊһ��
XNum=Width/8;
Cell=cell(YNum,XNum);               %�ֿ鴦���õ�Ԫ�����飨cell��Ԫ���飩
for i=1:YNum                        %��������-����������鴦��
    for j=1:XNum
        Cell{i,j}=izigzag(CoMat(:,(i-1)*XNum+j));   %��Zig-Zag����������ɨ���1*64��������ԭ8*8����
        Cell_DCT=Cell{i,j}.*QTAB;                   %����������
        Cell{i,j}=idct2(Cell_DCT);                  %idct2��ά��ɢ������任
        Cell{i,j}=round(Cell{i,j}+128);             %��128���и�ԭ
    end
end
Recovery=cell2mat(Cell);                %ƴ�Ӳ�������CellԪ�����黹ԭΪ������ʽ�������ԭͼ����ȫ��ͬ
snows_rec=uint8(Recovery);              %ת��Ϊuint8���ͣ���snow_rec��ʾ��ԭ�õ���ͼ�����

%--------------------------------------------�������-----------------------------------------%

%-----------------------------------------���۱����Ч��--------------------------------------%
snows=snow;         	%����ͼ��Ϊsnow.mat�еĻҶ�ͼ��snow
                            %���Ϊsnows,�������ԭʼ����snow
[Height,Width]=size(snows); %��ȡͼ���С
PixelNum=Height*Width;      %��������Ŀ�����ڼ���MSE
MSE=1/PixelNum*sum(sum((double(snows_rec)-double(snows)).^2));
                            %���ݹ�ʽ����MSE
PSNR=10*log10(255^2/MSE);   %���ݹ�ʽ����PSNR
subplot(1,2,1);             %��ͼ1
imshow(snows);              %����ԭͼ
title('ԭͼ');              %�趨����
imwrite(snows,'./chapter2_13/1ԭͼ.bmp');  %�����ͼƬ��������
subplot(1,2,2);            	%��ͼ2
imshow(snows_rec);          %��������JPEG����ͽ���֮��ԭ�õ���ͼ
title('JPEG����븴ԭͼ');   %�趨����
imwrite(snows_rec,'./chapter2_13/2JPEG����븴ԭͼ.bmp');  %�����ͼƬ��������
