clear all,close all,clc;
% �����ļ�2
% ���ܣ����ڹ۲������PRN�����봦���Ĳ������ݵ���غ���
%       �����鿴�Ƿ��з�ֵ���ҷ�ֵ�ľ��Դ�С��������Ϊ�۲��ж���Щ���ǿ��ܱ�����
%% ��������
CodeRate = 2.046e6;         %��Ƶ�ź����ʣ�ÿ��2.046e6����
CodeLength = 2046;          %���������ź��볤
Fs = 10e6;                  %�Խ����źŵĲ�����
load('BD_Code.mat');        %��ͬ������PRN����

%% ����ɼ�������
%fid = fopen('Test_Data_int16.dat', 'r');   %����ҵ�ṩ�Ĳ������ݣ���֪����ǰ5�����ǵ���Ƶ�ź�
fid = fopen('UEQ_rawFile_int16.dat','r');   %����ҵ�ṩ�����ݣ������������������δ֪
[data, count] = fread(fid, inf ,'int16');   %��ȡ������������Ϣ
SateNum = size(BD_Code,1);                  %��ȡ������Ŀ
Sample_Num = CodeLength/CodeRate*Fs;        %2046�����ڲ����ź��ж�Ӧ����Ŀ(10000)

%% ���ݳ�����������������ź���ƽ��
Group = count/Sample_Num;                   %���飬�൱�ڵõ������������ظ������˶��ٴ�PRN����
data_matrix = reshape(data,Sample_Num,Group);   %�������ݲ���
data_mean = mean(data_matrix,2);            %��������������£����յ��ź������ڵģ����������ź���λ��ͬ
                                            %��ƽ��ֵ�Դ˴������е�����
data_new = SampleMatchCode(data_mean',0.11);%ʹ��SampleMatchCode������data_meanתΪ����Ϊ2046����ɢ�ź�
for i = 1:SateNum
     Code_fft_conj = conj(fft(BD_Code(i,:)));  	%PRN���У������룩�Ĺ���FFT
    data_fft = fft(data_new);                   %�����źţ�����󣩵�FFT
    correlation = ifft(data_fft.*Code_fft_conj);%��������Ƶ�������ȡ�棬�õ�ʱ�����غ���
    figure(i);                              %��ͼ��
    stem(correlation);                      %��ͼ
end
