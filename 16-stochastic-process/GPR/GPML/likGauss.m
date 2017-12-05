function varargout = likGauss(hyperpara, y, mean, var, infmethod,i)
% ������
%   ��˹��Ȼ����(Gaussian Likelihood Function)�����ڸ�˹���̻ع�(GPR).
%   
% ����˵����
%   ��Ȼ������ʽ��
%       f(t) = exp(-(t-y)^2/(2*sn^2)) / sqrt(2*pi*sn^2)
%   ���У�y��Ӧ��˹�ֲ��ľ�ֵ�����̣�sn��Ӧ��˹�ֲ��ı�׼��sigma����.
%   �������ṩ�˶�����Ȼ������ʹ�÷������ֱ����ڼ�����Ȼֵ���������ء�
%
% ��������
%   hyperpara = log(sn)
%
% ����˵����
%   ���������
%       hyperpara��������
%       y        ����������
%       mean     �������ֵ
%       var      �����뷽��
%       infmethod���ƶϷ�ʽ���ṩLaplace���ơ���������(Expectation Propagation)
%                  ��������ֱ�Ҷ˹(Variational Bayesian)����
%   ���������
%   a) Laplace Approximation  ��{logprob,loglike_dr1,loglike_dr2,loglike_dr3}
%                               {logprob_dhyp,logprob_dr1_dhyp,logprob_dr2_dhyp}
%   b) Expectation Propagation��{logZ,logZ_dr1,logZ_dr2}
%                               {logZ_dr1_hyp}
%   c) Variational Bayesian   ��{b,y}
%   d) Default                ��{logprob,y_mean,y_var}

if nargin <= 2                                                  %�������С�ڵ���2
    varargout = {'1'};                           %δ�����ֵ�ͷ���ʱ����������ĿΪ1
    return;
end
sn2 = exp(2*hyperpara);                      %��hyperpara�õ���˹��Ȼ�����ķ������
if nargin <=4                                    %�����˾�ֵ�ͷ����δָ���ƶϷ�ʽ
  if isempty(y)
      y = zeros(size(mean)); 
  end
  var_zero = 1; 
  if nargin > 3 && numel(var) > 0 && norm(var) > eps
      var_zero = 0; 
  end
  if var_zero
    logprob = -(y - mean).^2./sn2/2 - log(2*pi*sn2)/2;              %������ʵ�log
    var = 0; 
  else
    logprob = likGauss(hyperpara, y, mean, var,'infEP');             %������������
  end
  y_mean = {}; y_var = {};
  if nargout > 1
    y_mean = mean;                                                 %y��һ�׾�(����)
    if nargout > 2
      y_var = var + sn2;                                                %y�Ķ��׾�
    end
  end
  varargout = {logprob,y_mean,y_var};
else
  switch infmethod
  %*********Laplace����*********%
  case 'infLaplace' 
	if nargin <= 5                                          %����Ҫ���㳬�����ĵ���
        if isempty(y)
            y = 0; 
        end
        y_center = y - mean;                                               %���Ļ�
        loglike_dr1 = {}; loglike_dr2 = {}; loglike_dr3 = {};%����ȡlog��һ�����׵�
        logprob = - y_center.^2/(2*sn2) - log(2*pi*sn2)/2;              %����ȡlog
        if nargout > 1
            loglike_dr1 = y_center/sn2;                    %��Ȼ����ȡlog��һ�׵���
            if nargout > 2                                 %��Ȼ����ȡlog�Ķ��׵���
                loglike_dr2 = -ones(size(y_center))/sn2;
                if nargout > 3                             %��Ȼ����ȡlog�����׵���
                loglike_dr3 = zeros(size(y_center));
                end
            end
        end
        varargout = {logprob,loglike_dr1,loglike_dr2,loglike_dr3};     %����������
    else                                                        %��Ҫ���㳬�����ĵ���
      	logprob_dhyp = (y - mean).^2/sn2 - 1;          %���ڳ������Ķ�����Ȼ�����ĵ���
        logprob_dr1_dhyp = 2*(mean - y)/sn2;                               %һ�׵���
        logprob_dr2_dhyp = 2*ones(size(mean))/sn2;                         %���׵���
        varargout = {logprob_dhyp,logprob_dr1_dhyp,logprob_dr2_dhyp};   %����������
    end
  %***********������������************%
  case 'infEP'                                                         %������������
    if nargin <= 5                                            %����Ҫ���㳬�����ĵ���
        logZ = -(y-mean).^2./(sn2 + var)/2 - log(2*pi*(sn2 + var))/2;%��ֺ���ȡ����
        logZ_dr1 = {}; logZ_dr2 = {};                             %��ֺ�����һ���׵�
        if nargout > 1
            logZ_dr1  = (y - mean)./(sn2 + var);                           %һ�׵���
            if nargout>2
                logZ_dr2 = -1./(sn2 + var);                                %���׵���
            end
        end
        varargout = {logZ,logZ_dr1,logZ_dr2};                          %����������
    else                                                        %��Ҫ���㳬�����ĵ���
     	logZ_dr1_hyp = ((y - mean).^2./(sn2 + var) - 1) ./ (1 + var./sn2);
        varargout = {logZ_dr1_hyp};                                     %����������
    end
  %***********��ֱ�Ҷ˹����***********%
  case 'infVB'  
    n = numel(var); 
    b = zeros(n,1); 
    y = y.*ones(n,1); 
    varargout = {b,y};
  end
end
