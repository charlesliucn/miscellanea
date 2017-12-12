clear all,close all,clc;
% ��.m�ļ���������źŵĲ����㷨������FFT_Acquisition_ver2�ĳ���������޸�
% ��Ҫ˼·�ǣ���һ����������Ϊ������㣬�Ӷ�����������Ӱ��
% ���ѡȡ2000�������е�ĳЩ���ڣ�����������㲢���ۼ�����
% ���ۼӺ�Ľ���������ֵ��⣬�����о����ޱȽϣ��о����޵�ѡȡ������֮ǰ��ͬ
% Ч����׼ȷ�����и��ƣ�ʱ�临�Ӷ����ӽ�����

%% ��������
CodeRate = 2.046e6;         %��Ƶ�ź����ʣ�ÿ��2.046e6����
CodeLength = 2046;          %���������ź��볤
Fs = 10e6;                  %�Խ����źŵĲ�����
load('BD_Code.mat');        %��ͬ������PRN����

%% ����ɼ�������
fid = fopen('Test_Data_int16.dat', 'r');   %����ҵ�ṩ�Ĳ������ݣ���֪����ǰ5�����ǵ���Ƶ�ź�
%fid = fopen('UEQ_rawFile_int16.dat','r');   %����ҵ�ṩ�����ݣ������������������δ֪
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
correlation = zeros(SateNum,CodeLength);
cor = zeros(1,SateNum);                         %�������洢��غ��������ֵ
maxindex = zeros(1,SateNum);                    %������غ������ֵ��Ӧ����ţ������ӳٻ�����λ�
% ʹ��Ƶ�������غ���(�ۼ���ط�)
NumPick = 20;                                   %��������ѡ���������Ŀ
interv = Group/NumPick;                         %ѡȡ����ʱ�ļ��
for i = 1:SateNum
    Code_fft_conj = conj(fft(BD_Code(i,:)));    %PRN���У������룩�Ĺ���FFT
    for j = 1:NumPick
        data_use = data_matrix(:,interv*(j-1)+1);   %���ѡȡ���е�NumPick������
        data_use = SampleMatchCode(data_use',0.11); %ʹ��SampleMatchCode������data_meanתΪ����Ϊ2046����ɢ�ź�
        data_fft = fft(data_use);                   %��ɢ�źţ�����󣩵�FFT
        correlation(i,:) = correlation(i,:) + ifft(data_fft.*Code_fft_conj); 
        %Ƶ�������ȡ�棬�õ�ʱ�����غ��������ҽ����ۼ�
    end
    [cor(i),maxindex(i)] = max(correlation(i,:));   %������ۼ�֮��Ľ�����о��Ƿ񲶻�ɹ�
end
Threshold = SetThreshold(cor);                  %SetThreshold����������ֵ
hold on;    plot(0:0.05:38,Threshold,'r');      %�������޵�λ�ã�ʹ�����ֱ��
result = find(cor > Threshold);                 %�ҳ�������ֵ�����ǣ���Ϊ���������
phase = maxindex(result);                       %��������Ƕ�Ӧ����λ
stem(1:SateNum,cor);                            %�Ը����Ƕ�Ӧ��������ֵ��ͼ
title('����FFT����ز����㷨--�Ż���');xlabel('���Ǳ��');ylabel('��ط�ֵ');   %��ע