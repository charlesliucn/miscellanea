function acquisition= MyAlgorithm (filename)
% ����FFT����ز����㷨
% ���룺
%   filename�����������ļ����ļ���
% �����
%   acquisition����������ǣ���һ�������Ǳ�ţ��ڶ�������λ

%% ��������
CodeRate = 2.046e6;         %��Ƶ�ź����ʣ�ÿ��2.046e6����
CodeLength = 2046;          %���������ź��볤
Fs = 10e6;                  %�Խ����źŵĲ�����
load('BD_Code.mat');        %��ͬ������PRN����

%% ����ɼ�������
%fid = fopen('Test_Data_int16.dat', 'r');   %����ҵ�ṩ�Ĳ������ݣ���֪����ǰ5�����ǵ���Ƶ�ź�
fid = fopen('UEQ_rawFile_int16.dat','r');   %����ҵ�ṩ�����ݣ������������������δ֪
[data, count] = fread(fid, inf ,'int16');   %��ȡ�ļ�����ȡ������������Ϣ
SateNum = size(BD_Code,1);                  %��������Ŀ
Sample_Num = CodeLength/CodeRate*Fs;        %2046�����ڲ����ź��ж�Ӧ����Ŀ(10000)

%% ���ݳ�����������������ź���ƽ��
Group = count/Sample_Num;                       %���飬�൱�ڵõ������������ظ������˶��ٴ�PRN����
data_matrix = reshape(data,Sample_Num,Group);   %�������ݲ���
data_mean = mean(data_matrix,2);                %��������������£����յ��ź������ڵģ����������ź���λ��ͬ
                                                %��ƽ��ֵ�Դ˴������е�����
data_new = SampleMatchCode(data_mean',0.11);    %ʹ��SampleMatchCode������data_meanתΪ����Ϊ2046����ɢ�ź�

%% �������������ź�����أ�������ֵ��˵�������������ź�
cor = zeros(1,SateNum);                         %�������洢��غ��������ֵ
maxindex = zeros(1,SateNum);                    %������غ������ֵ��Ӧ����ţ������ӳٻ�����λ�
%   ʹ��Ƶ�������غ���
for i = 1:SateNum           
    Code_fft_conj = conj(fft(BD_Code(i,:)));    %PRN���У������룩�Ĺ���FFT
    data_fft = fft(data_new);                   %�����źţ�����󣩵�FFT
    correlation = ifft(data_fft.*Code_fft_conj);%��������Ƶ�������ȡ�棬�õ�ʱ�����غ���
    [cor(i),maxindex(i)] = max(correlation);    %��غ������ֵ����Ӧ����ţ���λ��
end
Threshold = SetThreshold(cor);                  %SetThreshold����������ֵ
hold on;    plot(0:0.05:38,Threshold,'r');      %�������޵�λ�ã�ʹ�����ֱ��
result = find(cor > Threshold);                 %�ҳ�������ֵ�����ǣ���Ϊ���������
phase = maxindex(result);                       %��������Ƕ�Ӧ����λ
stem(1:SateNum,cor);                            %�Ը����Ƕ�Ӧ��������ֵ��ͼ
title('����FFT����ز����㷨--�Ż���');xlabel('���Ǳ��');ylabel('��ط�ֵ');   %��ע
acquisition = [result;phase];
