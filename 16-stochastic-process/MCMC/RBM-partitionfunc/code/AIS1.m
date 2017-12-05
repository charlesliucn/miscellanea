function AIS_LogConst = AIS1(W,a,b,M_run,beta)
% AIS(Annealed Importance Sampling)�㷨����RBM��һ������(û��batchdata)
% ���룺
%   W�� ���ز㵥Ԫ�Ϳɼ��㵥Ԫ��Ȩ�ع��ɵľ���
%   a�� ���ز㵥Ԫ��bias��
%   b�� �ɼ��㵥Ԫ��bias��
%   M_run��AIS���д�����
%   beta�������еĦ²��������������м亯����
% �����
%   AIS_LogConst��AIS�㷨�õ��Ĺ�һ����������ֵ.

%% ��base_rate model�Ļ�������
%base-rate model����ز�������*_base��ʾ
%W_base = 0*W;                          %base-rate model RBM��Ȩ�ؾ���WȡΪ0
b_base = 0*b;                           %base-rate model RBM�Ŀɼ���biasȫ��ȡ0
b_matrix_base = repmat(b_base,M_run,1);	%base-rate model �ɼ����bias
                                        %base-rate model RBM�����ز��biasȫ��Ϊ1
[num_vis,num_hid] = size(W);            %��ȡ�ɼ�������ز�ĵ���
%base-rate model�Ĺ�һ������(ȡlog)
LogConst_base = sum(log(1+exp(b_base)))+(num_hid)*log(2); %paper��ʽ4.18��ȡln, a = 0.

%% ���ó�ʼ�Ĳ�������paper��42ҳ���·��Ĺ�ʽ
a_mat = repmat(a,M_run,1); 
b_mat = repmat(b,M_run,1);

%% ��base-rate model���в���
Log_w = zeros(M_run,1);                             %��ʽ4.10�е�wȡln�ĳ�ֵ
v = repmat(1./(1+exp(-b_base)),M_run,1);           
v = v > rand(M_run,num_vis);                        %����base-rate model���ɳ�ʼv
Log_w = Log_w - (v*b_base' + num_hid*log(2));       %Log_w����base-rate model֮���ȡֵ

%% AIS�㷨����
 %��Ϊbeta(1)=0��Ӧ��base-rate model��֮ǰ�Ѿ������˼���
 %���Դ�beta(2)��ʼ�����һ��ֻ�������β��������ѭ���ṹ��ʵ��
 for beta_k = beta(2:end-1)                    
   exp_Wh = exp(beta_k*(v*W + a_mat));
   Log_w  =  Log_w + (1-beta_k)*(v*b_base') + beta_k*(v*b') + sum(log(1+exp_Wh),2); %paper��42ҳ���·���ʽ
   
   %��������Ʒ���ת������(Markov chain transition operator)
   hB_prob = exp_Wh./(1 + exp_Wh);      	%paper��ʽ4.16
   h_B = hB_prob > rand(M_run,num_hid);   	%�������ز�unit
   v = 1./(1 + exp(-(1-beta_k)*b_matrix_base - beta_k*(h_B*W' + b_mat)));%paper��ʽ4.17
   v = v > rand(M_run,num_vis);         	%���ɿɼ���unit

   %���¼�����
   exp_Wh = exp(beta_k*(v*W + a_mat));
   Log_w  =  Log_w - ((1-beta_k)*(v*b_base') + beta_k*(v*b') + sum(log(1+exp_Wh),2));
 end
 
%% ����beta(end)����RBMģ�͵Ĺ�һ������,ȡ����
    exp_Wh = exp(v*W + a_mat); 
    Log_w  = Log_w +  v*b' + sum(log(1+exp_Wh),2);
    
    %Ϊ��ֹ��ֵ̫��MATLAB�����ʹ��log��ʾ��ֵ
    dims = size(Log_w); 
    dim = find(dims >1 );
    out_base = max(Log_w,[],dim)-log(realmax)/2;
    dims_rep = ones(size(dims)); 
    dims_rep(dim) = dims(dim);
    log_sumw = out_base + log(sum(exp(Log_w - repmat(out_base,dims_rep)),dim));
    
    Log_rAIS = log_sumw -  log(M_run);      %paper��ʽ4.4
    AIS_LogConst = Log_rAIS + LogConst_base;        %paper��ʽ4.4ȡln�Ľ��

end