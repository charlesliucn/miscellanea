clear all,close all,clc;

load jpegcodes.mat;
DCL=length(DCCode);         %DCϵ���������������
ACL=length(ACCode);     	%ACϵ���������������
InputL=Height*Width*8;  	%�����ļ����ȣ�ת��Ϊ�����ƣ�ÿ��������Ҫ8λ
OutputL=DCL+ACL;        	%����������ȣ�����DCϵ������������ACϵ����������
COMR=InputL/OutputL;        %ѹ����=�����ļ�����/�����������