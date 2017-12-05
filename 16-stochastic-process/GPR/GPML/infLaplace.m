function [posterior,logMaLik,logZ_dr1,alpha] = infLaplace(hyperpara, meanfunc, kernel, likfunc, x, y, opt)
% ������
%   ��Ҷ˹�ƶϽ��Ʒ��� ֮ Laplace���Ʒ���(infLaplace)
% 
% ����˵����
%  ��˹���̺���ֲ��Ľ��ƣ�Laplace���ơ�
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

%% ׼������
infmethod = 'infLaplace';
persistent old_alpha;                 %persistent��������֤��������ʱǰһ�ε��øı��Ĳ������ݸ���һ�ε���
if any(isnan(old_alpha))        %��ǰһ�κ������ú����old_alpha�г���NaN,����old_alphaȫΪ0�����⺯������
    old_alpha = zeros(size(old_alpha));
end   % prevent
if nargin <= 6
    opt = [];                                                               %δ��������optʱ��opt����Ϊ��
end            
n = size(x,1);                                                                          %�����������ĳ���
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
likfun = @(f) feval(likfunc{:},hyperpara.lik,y,f,[],infmethod);                          %ȡlog����Ȼ����

if any(size(old_alpha) ~= [n,1])                                              %�ҵ�alpha�ͺ���f�ĵ������ 
  alpha = zeros(n,1);                                     %���old_alpha��С��ƥ�䣬��old_alpha��ֵΪ0����
else
  alpha = old_alpha;                                                               %������һ��ʹ�õ�alpha
  if Psi(alpha,mean,K.mvm,likfun) > -sum(likfun(mean)) 
    alpha = zeros(n,1);
  end
end

%% GPML�ṩ��IRLS�Ż�����
%�Ż�����(GPML p41-p52)
alpha = irls(alpha, mean,K,likfun, opt);%ʹ��IRLS(Iteratively Reweighted Least Squares,��Ȩ������С���˷���)
f = K.mvm(alpha)+mean;                                                                %����f(GPML ��ʽ3.33)
old_alpha = alpha;                                                                                %���²���
[logprob,logprob_dr1,logprob_dr2,logprob_dr3] = likfun(f);                      %�������ȡlog����һ�����׵�
W = -logprob_dr2;                                                                                   %����W
[logdB2,KW,dW,hyp_dr] = K.fun(W);      
posterior.alpha = K.P(alpha);                                                          %����ֵΪ�����alpha
posterior.sW = sqrt(abs(W)).*sign(W);                                                             %��������
posterior.L = @(r) - K.P(KW(K.Pt(r)));

logMaLik = alpha'*(f - mean)/2 - sum(logprob) + logdB2;                                  %�����Ե��Ȼ����ֵ
if nargout > 2                                                                      %��������2����Ҫ���㵼��
  fhat_dr1 = dW.*logprob_dr3;                      %fhat��һ�׵���:���㹫ʽdfhat=diag(inv(inv(K)+W)).*d3lp/2
  ahat_dr1 = fhat_dr1 - KW(K.mvm(fhat_dr1));                                                 %ahat��һ�׵���
  logZ_dr1 = hyp_dr(alpha,logprob_dr1,ahat_dr1);                                             %logZ��һ�׵���
  logZ_dr1.lik = zeros(size(hyperpara.lik));                                                         %��ʼ��
  for i = 1:length(hyperpara.lik)                                                           %��Ȼ�����ĳ�����
    [logprob_dhyp,logprob_dhyp_dr1,logprob_dhyp_dr2] = feval(likfunc{:},hyperpara.lik,y,f,[],infmethod,i);
    logZ_dr1.lik(i) = -dW'* logprob_dhyp_dr2 - sum(logprob_dhyp);
    b = K.mvm(logprob_dhyp_dr1);                          %�������b:��ʽb-K*(Z*b) = inv(eye(n)+K*diag(W))*b
    logZ_dr1.lik(i) = logZ_dr1.lik(i) - fhat_dr1'*(b-K.mvm(KW(b)));
  end
  logZ_dr1.mean = -mean_dr(alpha + ahat_dr1);
end

%% GPML ��ʽ3.35-3.39
%   Psi(alpha) = alpha'*K*alpha + likfun(f)
%   f = K*alpha+m
%   likfun(f) = feval(lik{:},hyp.lik,y,f,[],inf).
function [psi,psi_dr,f,alpha,logprob_dr,W] = Psi(alpha,m,mvmK,likfun)
% ���������ݹ�ʽ����Psi����һ�׵���
  f = mvmK(alpha)+m;
  [logprob,logprob_dr,logprob_dr2] = likfun(f); 
  W = -logprob_dr2;
  psi = alpha'*(f-m)/2 - sum(logprob);
  if nargout>1
      psi_dr = mvmK(alpha-logprob_dr); 
  end

%%IRLS��Ȩ������С�����㷨  
%ʹ��IRLS��Ȩ������С�����㷨�Ż�Psi������alpha
function alpha = irls(alpha, m,K,likfun, opt)
%% ������������
  if isfield(opt,'irls_maxit')
      maxiter = opt.irls_maxit;              %ţ�ٵ����㷨��󲽳�
  else
      maxiter = 20;                              %maxitĬ��ֵΪ20
  end
  if isfield(opt,'irls_Wmin')
      Wmin = opt.irls_Wmin;                %��Ȼ������������С����
  else
      Wmin = 0.0;                                      %Ĭ��ֵΪ0
  end
  if isfield(opt,'irls_tol')
      tol = opt.irls_tol;                        %ֹͣ����ʱ��ȡֵ
  else
      tol = 1e-6;                                   %Ĭ��ֵΪ1e-6
  end
  
  smin_line = 0; smax_line = 2;                %���������Сֵ����
  nmax_line = 10;                                       %�������
  threshold_line = 1e-4;                                %��ֵ����
  Psi_line = @(s,alpha,dalpha) Psi(alpha+s*dalpha,m,K.mvm,likfun);
  paras_line = {smin_line,smax_line,nmax_line,threshold_line};
  search_line = @(alpha,dalpha) brentmin(paras_line{:},Psi_line,5,alpha,dalpha);
  f = K.mvm(alpha)+m; 
  [~,logprob_dr1,logprob_dr2] = likfun(f); 
  W = -logprob_dr2; 
  Psi_new = Psi(alpha,m,K.mvm,likfun);
  Psi_old = Inf;
  iter = 0;
  
%% ţ�ٵ�������
  while Psi_old - Psi_new > tol && iter < maxiter   %ţ�ٵ�����ʼ
    Psi_old = Psi_new; 
    iter = iter+1;
    W = max(W,Wmin);                     %ͨ���������ʼ�С��������
    [~,solveKiW] = K.fun(W); b = W.*(f-m) + logprob_dr1;
    dalpha = b - solveKiW(K.mvm(b)) - alpha;        %ţ�ٵ�����ʽ
    [~,Psi_new,~,~,f,alpha,logprob_dr1,W] = search_line(alpha,dalpha);
  end                                               %ţ�ٵ�������