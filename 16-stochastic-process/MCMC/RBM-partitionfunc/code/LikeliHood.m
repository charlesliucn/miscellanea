function Log_Like = LikeliHood(W,a,b,logZ,data,num_test)
% ���ݹ��Ƶõ��Ĺ�һ��������������������ϵ�����Ȼֵ
% ���룺
%   W�� ���ز㵥Ԫ�Ϳɼ��㵥Ԫ��Ȩ�ع��ɵľ���
%   a�� ���ز㵥Ԫ��bias��
%   b�� �ɼ��㵥Ԫ��bias��
%   logZ���㷨�õ��Ĺ�һ����������ֵ��ȡlog����
%   testbatchdata����������
% �����
%   Log_Like�����������ϵ�����Ȼֵ

%% ������������ϵ�����Ȼֵ
Pv = exp(data*b' + sum(log(1+exp(ones(num_test,1)*a + data*W)),2) - logZ);
Log_Like = sum(Pv);
