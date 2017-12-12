function pdata = SampleMatchCode(rawdata,bias)
% SampleMatchCode����
% ���ܣ�����Ƶ�ź�һ�����ڵĲ�������(����Ϊ10000)��Ӧ������Ϊ2046����ɢ�źţ��Ա��뱾��PRN���������
% ˼·������Ƶ�ź�һ�����ڵĲ�������(����Ϊ10000)�ȶ�Ӧ��2046�����䣬�ٶԸ������ڵ�����ȡ��ֵ����Ϊ������Ĵ���
% ���룺
%       rawdata�������õ������ݣ������ǳ������������ݣ���Ӧ��Ƶ�źŵ�һ�����ڣ�
%       bias�� 	΢�������㣬ʹ�þ����ܶ����Ƶ�źŵ��׸��������Ӧһ����Ԫ����ʼλ�ã�
% �����
%       pdata��  ���������ݣ�������PRN������ͬ�����ɽ����������


    CodeLength = 2046;                      %PRN���еĳ���
    num = length(rawdata);                  %��Ƶ�ź�һ�����ڵĲ������ݵĳ��ȣ�������Ƶ��Ϊ10MHzʱ������Ϊ10000
    pdata = zeros(1,CodeLength);            %��ʼ���������ݣ����ȵ���PRN����
    %��10000�����ݵ��Ӧ��2046������
    lowerbound = zeros(1,CodeLength);       %��ʼ��������½�
    upperbound = zeros(1,CodeLength);       %��ʼ��������Ͻ�
    lowerbound(1) = 1;                      %���ڵ�һ���������⴦�������½�Ϊ1�����ӵ�һ�����ݿ�ʼ
    upperbound(1) = floor(num/CodeLength);  %���ڵ�һ���������⴦�������Ͻ���㹫ʽ
    pdata(1) = mean(rawdata(lowerbound(1):upperbound(1)));  %�Ե�һ���������⴦����ȡ��һ�������ڵľ�ֵ
    for i = 2:CodeLength                                    %��֮���ÿ����������ͬ����
        upperbound(i) = floor(num*(i-bias)/CodeLength);     %��ȡ�����Ͻ�
        lowerbound(i) = ceil(num*(i-bias-1)/CodeLength);    %��ȡ�����½�
        pdata(i) = mean(rawdata(lowerbound(i):upperbound(i)));  %�����������ݵľ�ֵ
    end
end