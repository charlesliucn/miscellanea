clear all,close all,clc;
% ��.m�ļ�Ϊ���ʵ�ֵ��㷨������˼���ǻ���FFT����ؼ��㡣
% �Բ������ݵ�Ԥ����������ע�ͣ���Ҫ������Ϊ20,000,000������תΪ����Ϊ2046������
% ��Ҫ˵�������⣺
% 1. PRN���г���Ϊ2046��ÿ�����ڲ����õ������ݳ���Ϊ10000
% 2. ��.m�ǰ���һ�������(20,000,000��������ƽ�����)10000����������ѡ�����ݣ����ɳ���Ϊ2046����ɢ�ź�
% 3. �о���������Ϊ�۲���ͼ������趨�ģ����������Ϊһ���㷨
% ֮��İ汾����������������޸ĺ�����

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

%% ���ݳ�����������������źŷֳ�2000�����ƽ��
Group = count/Sample_Num;                       %���飬�൱�ڵõ������������ظ������˶��ٴ�PRN����
data_matrix = reshape(data,Sample_Num,Group);  	%�������ݲ���
data_mean = mean(data_matrix,2);                %��������������£����յ��ź������ڵģ����������ź���λ��ͬ
                                                %��ƽ��ֵ�Դ˴������е�����
data_new = data_mean(1:Sample_Num/CodeLength:Sample_Num)';  %�ӳ���Ϊ10000��data_mean�м��ѡȡ2046������ֵ

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
Threshold = 7e4;                                %�˴�����ֵ���о����ޣ�������Ϊ�趨��
hold on;    plot(0:0.05:38,Threshold,'r');      %�������޵�λ�ã�ʹ�����ֱ��
result = find(cor > Threshold);                 %�ҳ�������ֵ�����ǣ���Ϊ���������
phase = maxindex(result);                       %��������Ƕ�Ӧ����λ
stem(1:SateNum,cor);                            %�Ը����Ƕ�Ӧ��������ֵ��ͼ
title('����FFT����ز����㷨--version1(�������ݼ��ѡȡ)');xlabel('���Ǳ��');ylabel('��ط�ֵ');    %��ע