clear all,close all,clc;
% ���ļ���1�����ǵ�PRN����Ϊ��������������������PRN���е���غ���
% �Ӷ��Ƚ�����PRN���е�����غ������벻ͬ���ǵĻ���غ���

load('BD_Code.mat');        %��ͬ������PRN����
SateNum = size(BD_Code,1);  %��ȡ���ǵ���Ŀ
cor = zeros(1,SateNum);     %��ʼ����غ�����ֵ��ʸ��
CodeA = BD_Code(1,:);       %��1������Ϊ������PRN�������������ǵ�PRN���������
for i = 1:SateNum
    A_fft_conj = conj(fft(CodeA));  %1������PRN���У������룩�Ĺ���FFT
    B_fft = fft(BD_Code(i,:));      %��һ������PRN���е�FFT
    correlation = ifft(B_fft.*A_fft_conj);%��������Ƶ�������ȡ�棬�õ�ʱ�����غ���
    cor(i) = max(correlation);      %��غ������ֵ
end
stem(1:SateNum,cor);                %��ͼ
title('1��������37�����ǵ���ط�ֵ');xlabel('���Ǳ��');ylabel('��ط�ֵ');