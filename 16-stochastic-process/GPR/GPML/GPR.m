function varargout = GPR(hyperpara, infmethod, meanfunc, kernel, likfunc, xtrain, ytrain, xtest)
% ������
%   ��˹���̻ع�(Gaussian Process Regresssion,GPR)������
%
% ���ܣ�
%   ���ڸ�˹���̻ع�(GPR)���ƶϺ�Ԥ�⡣
%       ����Ϊ��˹���̣��ɾ�ֵ������Э�����(�˺���,kernel function)
%   Ψһȷ������������Ҫ����ѵ������ʹ�ø�˹���̻ع�ʵ��ģ�͵�ѡ�񣬲���
%   ��ѡ���ģ�ͽ������ݵ�Ԥ�⡣
%
% ʹ��˵����
%   ʹ��ʱ��Ϊ���������
%   1. ֻ����ѵ�����ݡ��������ѵ���õ��ı�Ե��Ȼֵ(marginal likelihood)�ͳ�������
%   [logMaLik,dlogMaLik]                 = gp(hyp, inf, mean, cov, lik, x, y);
%   2. ����ѵ�����ݺͲ������ݡ��������ѵ����Բ������ݵ�Ԥ������
%   [mean_test,var_test,mean_lat,varlat] = gp(hyp, inf, mean, cov, lik, x, y, xs);
%
% ����˵����
%   ���������
%       hyperpara����ֵ�������˺�������Ȼ�����еĳ�����(hyperparameters)
%       infmethod�������ƶϵķ��� 
%       meanfun  ��(����)��ֵ����
%       kernel   ��(����)Э�����(�˺���)
%       likfun   ����Ȼ����
%       xtrain   ��ѵ�����ݵ�����
%       ytrain   ��ѵ�����ݵ����
%       xtest    ���������ݵ�����
%   ���������
%   1.��һ��ʹ�÷�����
%       logMalik ����Ե��Ȼֵ(ȡlog��ȡ��)
%       dlogMalik�����ھ�ֵ��Э�����Ȼ�����������ı�Ե��Ȼ��ƫ����(������)
%   2.�ڶ���ʹ�÷�����
%       mean_test���Բ������ݵ�Ԥ��-��ֵ
%       var_test ���Բ������ݵ�Ԥ��-����
%       mean_lat ��Ԥ���ֵ
%       var_lar  ��Ԥ�ⷽ��

%%  ���þ�ֵ����
if isempty(meanfunc)                    %�����ֵ����Ϊ��ʱ��ʹ��Ĭ�ϵľ�ֵ����meanZero
    meanfunc = {@meanZero};                                         %���meanZero����
end
if ischar(meanfunc) || isa(meanfunc, 'function_handle')
    meanfunc = {meanfunc};                                %����ľ�ֵ����������Ԫ������
end

%%  ���ú˺���
if isempty(kernel)                                                 %GPR�к˺�������Ϊ��
    error('Error:����˺�������Ϊ�գ�');                                   %��ʾ���ִ���
end
if ischar(kernel) || isa(kernel,'function_handle')
    kernel  = {kernel};                                      %����ĺ˺���������Ԫ������
end                         
kernelinput = kernel{1};                                                  %����ĺ˺���
if isa(kernelinput,'function_handle')
    kernelinput = func2str(kernelinput);                   %���������תΪ���������ַ���
end
%%  ������Ȼ����
if isempty(likfunc)
    likfunc = {@likGauss};                                       %Ĭ����Ȼ����Ϊ��˹����
end
if ischar(likfunc) || isa(likfunc,'function_handle')
    likfunc = {likfunc};                                      %������Ȼ����������Ԫ������
end
likefuninput = likfunc{1};                                               %�������Ȼ����
if isa(likefuninput,'function_handle')
    likefuninput = func2str(likefuninput);              %���������ת��Ϊ�������Ƶ��ַ���
end

%%  �����ƶϷ���
if isempty(infmethod)
    infmethod = {@infGaussLik};                                  %Ĭ���ƶϷ�ʽΪ��˹�ƶ�
end
if ischar(infmethod)
    infmethod = str2func(infmethod);                %���ƶϷ�ʽ���Ƶ��ַ���ת��Ϊ�������
end
if ischar(infmethod) || isa(infmethod,'function_handle')
    infmethod = {infmethod};                                %������ƶϷ�ʽ������Ԫ������
end
infmethodinput = infmethod{1};                                           %������ƶϷ�ʽ
if isa(infmethodinput,'function_handle')
    infmethodinput = func2str(infmethodinput);       %��������ƶϷ�ʽ�ĺ������תΪ�ַ���
end
if strcmp(infmethodinput,'infPrior') 
  infmethodinput = infmethod{2};                     %�ַ����Ƚϣ������ƶϽ������Ԫ������
end

%% ������������
D = size(xtrain,2);
if ~isfield(hyperpara,'mean')
    hyperpara.mean = [];                                          %��ֵ�����ĳ�������Ϊ��
end
if ~isfield(hyperpara,'cov')
    hyperpara.cov = [];                                             %�˺����ĳ�������Ϊ��
end
if ~isfield(hyperpara,'lik')
    hyperpara.lik = [];                                           %��Ȼ�����ĳ�������Ϊ��
end
if eval(feval(meanfunc{:})) ~= numel(hyperpara.mean)
  error('Error������ľ�ֵ�����ĳ������������ֵ����������');                  %��ʾ������Ϣ
end
if eval(feval(kernel{:})) ~= numel(hyperpara.cov)
  error('Error������ĺ˺����ĳ�����������˺���������');                      %��ʾ������Ϣ       
end
if eval(feval(likfunc{:})) ~= numel(hyperpara.lik)
  error('Error���������Ȼ�����ĳ�������������Ȼ����������');                  %��ʾ������Ϣ
end
%%
if nargin > 7                      %������ʹ��ģʽΪ�ڶ���(�в�������)ʱ�������Ե������Ȼֵ
    if isstruct(ytrain)
        posterior = ytrain;
    else
        posterior = feval(infmethod{:}, hyperpara, ...  %feval�������ƺ����ڸ�����������ֵ
            meanfunc, kernel, likfunc, xtrain, ytrain);
    end
else
    if nargout <= 1
      [posterior,logMalik] = feval(infmethod{:}, hyperpara, ...
          meanfunc, kernel, likfunc, xtrain, ytrain);   %feval�������ƺ����ڸ�����������ֵ
      dlogMalik = {};                                                        %ƫ����Ϊ��
    else
      [posterior,logMalik,dlogMalik] = feval(infmethod{:},hyperpara,...
          meanfunc, kernel, likfunc, xtrain, ytrain);   %feval�������ƺ����ڸ�����������ֵ
    end
end

if nargin == 7                                        %������ʹ�õ�һ��ģʽ(û�в�������)ʱ
	varargout = {logMalik, dlogMalik, posterior};            %�����Ե��Ȼֵ��ƫ�����ͺ�����
else
    alpha = posterior.alpha;                                  	  %����������alpha,L��sW
    L = posterior.L;
    sW = posterior.sW;
    if issparse(alpha)
        nonzero = (alpha ~= 0);                                              %����ֵ��ָ��
        if issparse(L)
            L = full(L(nonzero,nonzero)); 
        end
        if issparse(sW)
            sW = full(sW(nonzero)); 
        end
    else
        nonzero = true(size(alpha,1),1); 
    end
    if isempty(L)                                                   %Lδ����ʱ�������м���L
        K = feval(kernel{:}, hyperpara.cov, xtrain(nonzero,:));
        L = chol(eye(sum(nonzero))+sW*sW'.*K);
    end
    
    Lchol = isnumeric(L) && all(all(tril(L,-1)==0)&diag(L)'>0&isreal(diag(L))');
    ntest = size(xtest,1);                                                   %�������ݸ���
    if strncmp(kernelinput,'apxGrid',7)
        xtest = apxGrid('idx2dat',kernel{3},xtest); 
    end
    %�������ݽ����ʼ��
 	mean_test = zeros(ntest,1); 
    var_test  = zeros(ntest,1);
    mean_lat  = zeros(ntest,1);
    var_lat   = zeros(ntest,1);
    nperbatch = 10;                                     %��������ʱ��ÿbatch�Ĳ������ݸ���
    nprced = 0;                                                     %�Ѿ�����Ĳ������ݸ���
    while nprced < ntest                                         %����ÿ��(batch)�Ĳ�������
        id = (nprced+1):min(nprced + nperbatch,ntest);            %��Ҫ����Ĳ������ݵĽǱ�
        kss = feval(kernel{:}, hyperpara.cov, xtest(id,:), 'diag'); 
        if strcmp(kernelinput,'covFITC') || strcmp(kernelinput,'apxSparse')
            Ks = feval(kernel{:}, hyperpara.cov, xtrain, xtest(id,:)); Ks = Ks(nonzero,:);
        else
            Ks = feval(kernel{:}, hyperpara.cov, xtrain(nonzero,:), xtest(id,:));
        end
        ms = feval(meanfunc{:}, hyperpara.mean, xtest(id,:));
    	N = size(alpha,2);
        mean_cond = repmat(ms,1,N) + Ks'*full(alpha(nonzero,:));          %�����ֲ��ľ�ֵ
        mean_lat(id) = sum(mean_cond,2)/N;                                    %Ԥ��ľ�ֵ
        if Lchol
            V  = L'\(repmat(sW,1,length(id)).*Ks);
            var_lat(id) = kss - sum(V.*V,1)';                                 %Ԥ��ķ���
        else
            if isnumeric(L)
                LKs = L*Ks; 
            else
                LKs = L(Ks);
            end
            var_lat(id) = kss + sum(Ks.*LKs,1)';                              %Ԥ��ķ���
        end
        var_lat(id) = max(var_lat(id),0);                                       %ȥ������
        var_cond = repmat(var_lat(id),1,N);                                     %��������
        if nargin < 9
            [Lp, Ymu, Ys2] = feval(likfunc{:},hyperpara.lik,[],mean_cond(:),var_cond(:));
        end
        mean_test(id) = sum(reshape(Ymu,[],N),2)/N;         
        var_test(id) = sum(reshape(Ys2,[],N),2)/N;
        nprced = id(end);                                  %���Ǳ�����Ϊ��һ����������ݵ�
    end
    varargout = {mean_test, var_test, mean_lat, var_lat};               %��������������
end
