function [posterior, logZ, logZ_dr] = infVB(hyperpara, meanfunc, kernel, likfunc, x, y, opt)
% ������
%   ��Ҷ˹�ƶϽ��Ʒ��� ֮ ��ֱ�Ҷ˹����(Variational Bayesian)
%
% ����˵����
%   ��˹���̺���ֲ��Ľ��ƣ���ֱ�Ҷ˹���ơ�
%
% ����˵����
%   ���������
%       hyperpara��������(hyperparameters)
%       meanfunc ����ֵ����
%       kernel   ���˺���(Э�����)
%       likfunc  ����Ȼ����
%       x        �������Ա���(����)
%       y        ��������Ӧ���
%       opt      ���Ż�����

n = size(x,1);                                                                          %�����������ĳ���
if nargin <= 6
    opt = [];                                                               %δ��������optʱ��opt����Ϊ��
end            
if isstruct(kernel)
    K = kernel;                                                              %ʹ������ĺ˺���(Э�����)
else
    K = apx(hyperpara,kernel,x,opt); 
end                                                                              %Э�������(apx���ƺ���)
if isnumeric(meanfunc)
    mean = meanfunc;                                                                  %ʹ������ľ�ֵ����
else
    [mean,mean_dr] = feval(meanfunc{:},hyperpara.mean,x);                           %�����ֵ�������䵼��
end
if iscell(likfunc)
    likstr = likfunc{1}; 
else
    likstr = likfunc; 
end
if ~ischar(likstr)
    likstr = func2str(likstr);
end

if ~isfield(opt,'postL')
    opt.postL = false; 
end
if isfield(opt,'out_nmax')
    out_nmax = opt.out_nmax;
else
    out_nmax = 15;                                                                         %Ĭ��ֵ����
end
if isfield(opt,'out_tol')
    out_tol  = opt.out_tol;
else
    out_tol = 1e-5;                                                                        %Ĭ��ֵ����
end

sW = ones(n,1);                                                                                %��ʼ��
opt.postL = false;
for i=1:out_nmax
  [~,~,Wdr] = K.fun(sW.*sW); v = 2*Wdr;
  [posterior,~,~,alpha] = infLaplace(hyperpara, meanfunc, K, {@varibayes,v,likfunc}, x, y, opt);
  sW_old = sW; f = K.mvm(alpha)+mean;
  [lp,~,~,sW,b,z] = feval(@varibayes,v,likfunc,hyperpara.lik,y,f);
  if max(abs(sW-sW_old)) < out_tol
      break;
  end
end

posterior.sW = sW;                                                                      %�������
[logdB2,KW,Wdr,hyp_dr] = K.fun(sW.*sW); 
posterior.L = @(r) -K.P(KW(K.Pt(r)));

gamma = 1./(sW.*sW); 
beta = b + z./gamma;
h = f.*(2*beta-f./gamma) - 2*lp - v./gamma; %���㹫ʽ��h(ga) = s*(2*b - f/ga)+ h*(s) - v*(1 / ga)
t = b.*gamma + z - mean; 
logZ = logdB2 + (sum(h)+ t'*KW(t) - (beta.*beta)'*gamma)/2;                             %�������

if nargout > 2                                                       %�����������2��ʱ��Ҫ���㵼��
  logZ_dr = hyp_dr(alpha);                                                            % Э�������
  logZ_dr.lik = zeros(size(hyperpara.lik));                                               %��ʼ��
  if ~strcmp(likstr,'likGauss')                                                      %��˹��Ȼ����
    for j=1:length(hyperpara.lik)
      sign_fmz = 2*(f-z >= 0)-1;
      g = sign_fmz.*sqrt((f - z).^2 + v) + z;
      dhhyp = -2*feval(likfunc{:},hyperpara.lik,y,g,[],'infLaplace',j);
      logZ_dr.lik(j) = sum(dhhyp)/2;
    end  
  else                                                                       %��˹�����µ����⴦��
    sn2 = exp(2*hyperpara.lik); 
    logZ_dr.lik = - sn2*(alpha'*alpha) - 2*sum(Wdr)/sn2 + n;
  end
  logZ_dr.mean = - mean_dr(alpha);                                               %��ֵ�����ĳ�����
end

function [varargout] = varibayes(var, likfunc, varargin)
% ������
%   ��ֱ�Ҷ˹��Ȼ����
%   varibayes(f) = lik(..,g,..)*exp(b*(f - g))
%   g = sign(f - z)*sqrt((f - z)^2 + v) + z
%   p(y|f) \ge exp((b + z/ga)*f - f.^2/(2*ga) - h(ga)/2)
% ����˵����
%   var    ����Ե��Ȼ�ķ���
%   likfunc��������Ȼ������ʽ

  [b,z] = feval(likfunc{:},varargin{1:2},[],zeros(size(var)),'infVB');
  f = varargin{3};
  sign_fmz = 2*(f-z>=0)-1;
  g = sign_fmz.*sqrt((f-z).^2 + var) + z;
  varargin{3} = g;
  id = (var==0 | abs(f./sqrt(var+eps))>1e10);

  varargout = cell(nargout,1);                                      %��ʼ�����
  [varargout{1:min(nargout,3)}] = feval(likfunc{:},varargin{1:3},[],'infLaplace');
  if nargout > 0
    logprob = varargout{1}; 
    varargout{1} = logprob + b.*(f - g);
    varargout{1}(id) = logprob(id);
    if nargout > 1                                              %��Ҫ��һ�׵���
      dg_df = (abs(f - z) + eps)./(abs(g - z)+eps);    %var=0,f=0ʱ�ȶ���dg/df
      logprob_dr = varargout{2};
      varargout{2} = logprob_dr.*dg_df + b.*(1-dg_df);
      varargout{2}(id) = logprob_dr(id); 
      if nargout > 2                                           % ��Ҫ����׵���
        logprob_dr2 = varargout{3};
        g_e = g - z + sign_fmz*eps;
        v_g3  = var./(g_e.*g_e.*g_e);                             %�ȶ���v/g^3
        varargout{3} = (logprob_dr - b).*v_g3 + logprob_dr2.*dg_df.*dg_df;
        varargout{3}(id) = logprob_dr2(id);
        if nargout > 3
          W = abs((b - logprob_dr)./(g - z + sign_fmz/1.5e8));
          varargout{4} = sqrt(W);
          if nargout > 4
            varargout{5} = b;
            if nargout > 5
              varargout{6} = z;
            end
          end
        end
      end
    end
  end