function RTS_LogConst = RTS(W,a,b,beta,N)
% RTS(Rao-Blackwellized Tempered Sampling)�㷨����RBM��һ��������by ��ǰ��
% ���룺
%   W�� ���ز㵥Ԫ�Ϳɼ��㵥Ԫ��Ȩ�ع��ɵľ���
%   a�� ���ز㵥Ԫ��bias��
%   b�� �ɼ��㵥Ԫ��bias��
%   N�� ���д�����
%   beta�������е�beta���������������м亯����
% �����
%   RTS_LogConst��RTS�㷨�õ��Ĺ�һ����������ֵ.

%% ׼������
    K = length(beta);                   %��betaȷ��K�Ĵ�С
    r = 1/K *ones(1,K);                 %r_kȫȡΪ1/K
    [num_vis,num_hid] = size(W);        %����Ȩֵ�����ȡ���ز�Ϳɼ���unit��Ŀ
    L = 10;                             %��ʼ����ʼ��beta

%% ��ʼ��
    %Z�ĳ�ʼ��
    Z = zeros(1,K);                     %Z����K��
    Z(1) = 1;                           %Z(1)��ʼֵΪ1
    Z(2:end) = linspace(1,10e100,K-1);  %����������
    %c�ĳ�ʼ��(ȫΪ0)
    c = zeros(1,K);
    %��ʼ��beta(1)=0��Ӧ�ķֲ���������AIS�㷨�е�base-rate model
    b_base = 0*b;                       %base-rate model RBM�����ز�biasȫΪ0
    %W_base = 0*W;                      %base-rate model RBM��Ȩ�ؾ���WȡΪ0
    v = rand(1,num_vis);                %�����������
    v = v > b_base;                     %��ʼ���ɼ���unit��ȡֵ
    %����base-rate model RBMģ�͵Ĺ�һ������
    Z_base = sum(log(1+exp(b_base)))+sum(log(1+exp(a)));        %AIS��papar��ʽ4.18           
    %��ʼ��c��r�ļ��
    diff = 1/K;

 %% ִ��RTS�㷨
while diff >= 0.1/K                     %RTS�㷨�������������ο�����2.5���Ϸ�����ʾ
    for j = 1:N
        %��������Ʒ���ת������(Markov chain transition operator)����֤q(x|beta) ����
        %%%%ע��˴���AIS�㷨��ʵ�ֵķ�����ͬ
        hB_prob = 1./(1+exp(-beta(L)*(v*W+a)));     %AIS paper��ʽ4.16
        h_B = hB_prob > rand(1,num_hid);            %�������ز�unit
        v = 1./(1+exp(-(1-beta(L))*(b_base))-(beta(L))*(h_B*W'+b)); %AIS paper��ʽ4.17
        v = v > rand(1,num_vis);                    %���ɿɼ���unit
     
        % ��q(beta|x)�����õ�beta|x
        %%%%����ԭ��paper��ʽ7������q(beta|x)���������ռ�ı�����ʾ����ʱbeta�ĸ���
        log_qxr = (1-beta)*(v*b_base')+sum(log(1+exp(a'*(1-beta))))+ beta*(v*b')+sum(log(1+exp((v*W+a)'*beta)));   %paper��ʽ7�ķ���(��ͬbeta)
        log_qxr  = log_qxr - (1-beta)*Z_base;
        qxr = exp(log_qxr);
        SumQ = sum(qxr);                             %��� paper��ʽ7�еķ�ĸ
        th = rand();                                %���������������ѡ��beta
        prob = 0;                                   %���ʳ�ʼ
        for i = 1:K
            prob = prob + qxr(i)/SumQ;               %����õ�����
            if th < prob    L = i; break;    end     %�Ƚ��ҵ����ʵ�beta����Ϊ�����õ���beta
        end
        % ����c�Ĵ�С
        c = c + 1/N*qxr/SumQ;                        %c�ĵ������¹�ʽ
    end
    %����Z
    Z(2:K) = Z(2:K).*(r(1)*c(2:K))./(c(1)*r(2:K));  %Z_RTS�ĵ������¹�ʽ
    diff = max(abs(c-r));                           %����r��c֮��Ĳ�࣬�����ж��Ƿ�����㷨Ҫ��
end
%% �㷨�������õ����
    RTS_LogConst = log(Z(end));                     %�õ���һ�������Ĺ���ֵ
    
