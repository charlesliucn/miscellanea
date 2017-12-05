function [meanfunc,deriv] = meanZero(hyperpara, input)
% ������
%   ���ֵ������
% ���ܣ�
%   ��ֵ����Ϊ0�������κβ���(����Ϊ��)
% ����˵����
%   ���������
%       hyperpara��������(hyperparameter),�˺���Ϊ�ա�
%       input    �������
%   ���������
%       meanfunc ����ֵ����
%       deriv    ��������

    if nargin < 2
        meanfunc = '0';                       %��ֵ����Ϊ0
        return;
    end
    meanfunc = zeros(size(input,1),1);          % ��ֵ����
    deriv = @(q) zeros(0,1);                 	% ������
end
