clear all,close all,clc;

load jpegcodes.mat;     %��ȡ����õ���������ͼ������Ϣ
load JpegCoeff.mat;     %��ȡJpegCoeff.mat����
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
hallg_rec=uint8(Recovery);              %ת��Ϊuint8���ͣ���hall_rec��ʾ��ԭ�õ���ͼ�����
save('jpegdecodes.mat','hallg_rec');    %���Ϊjpegdecodes.mat