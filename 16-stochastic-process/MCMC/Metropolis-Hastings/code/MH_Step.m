function R = MH_Step(step)

Sample_Num = step*10000;
sample = zeros(2,Sample_Num);%���ڱ������ɵ������������һ�д洢x1,�ڶ��д洢��Ӧ��x2

%��˹�ֲ���ΧΪ���ѡ��һ�����ʴ�С�ķ�Χ,������ͼ�Ƚ�
x1_range = [0,10];      %x1�ķ�Χ
x2_range = [0,20];  	%x2�ķ�Χ
psigma1 = 1;
psigma2 = 4;
n = 1;                  %n���ڼ�¼���������������ʼ��Ϊ1

%������ɵĳ�ֵ��Ϊ��һ���������
sample(1,n) = unifrnd(x1_range(1),x1_range(2));    %ʹ��unifrnd��x1��ȡֵ��Χ��ѡȡx1�ĳ�ֵ
sample(2,n) = unifrnd(x2_range(1),x2_range(2));    %ʹ��unifrnd��x2��ȡֵ��Χ��ѡȡx2�ĳ�ֵ

%%Metropolis-Hastings�㷨�����������
for n = 1:Sample_Num-1
    x1_next = normrnd(sample(1,n),psigma1);	%ʹ��normrnd����������x1Ϊ��ֵ��psigma1Ϊ��������������Ϊx1_next
    x2_next = normrnd(sample(2,n),psigma2); %ʹ��normrnd����������x2Ϊ��ֵ��psigma2Ϊ��������������Ϊx2_next
    temp1 = bigauss(x1_next,x2_next)/bigauss(sample(1,n),sample(2,n)); %������ʣ���1�Ƚ�ȡ��Сֵ
    paccept = min(1,temp1);                 %����õ�accept probability
    U = rand;                             	%��[0,1]�ľ��ȷֲ���ѡȡһ�������U
    if U < paccept                         	%��U��accept probabilityСʱ������
       sample(1,n+1) = x1_next;          	%��x1_next��Ϊ���º��x1
       sample(2,n+1) = x2_next;             %��x2_next��Ϊ���º��x2
    else
       sample(1,n+1) = sample(1,n);         %���򣬽�ǰһ��x1(n)��Ϊ���º��x1(n+1)
       sample(2,n+1) = sample(2,n);         %��ǰһ��x2(n)��Ϊ���º��x2(n+1)
    end
end

%���ݲ���������������ƶ�ά��˹�ֲ������ϵ��
X1 = sample(1,1:step:end);               %��������е�X1
X2 = sample(2,1:step:end);               %��������е�X2
L = length(X1);
E1 = sum(X1)/L;                 %X1�ľ�ֵ
E2 = sum(X2)/L;                 %X2�ľ�ֵ
Var1 = sum((X1-E1).^2)/L;       %X1����������
Var2 = sum((X2-E2).^2)/L;       %X2����������
E12 = sum(X1.*X2)/L;            %������������E(X1X2)
Cov= E12-E1*E2;                 %����Э����
R = Cov/sqrt(Var1*Var2);        %�õ����ϵ��

%��ͼ�Ƚ�
% figure;
% subplot(1,2,1);                 %��ͼ1��������ʵ�ֲ�ͼ
% num = 100;                      %ÿ������Χ�ֵĶ���
% xx1 = linspace(x1_range(1),x1_range(2),num); %��x1�����Ϊnum��
% xx2 = linspace(x2_range(1),x2_range(2),num); %��x2�����Ϊnum��
% [x1g,x2g] = meshgrid(xx1,xx2);  %���ɾ��󣬾�������
% f = bigauss(x1g,x2g);           %�������˹�ֲ��ڸ���ĸ����ܶ�
% surf(x1g,x2g,f);                %���������ܶȷֲ�ͼ
% xlabel('X1');                   %��ά������x��������ΪX1
% ylabel('X2' );                  %��ά������x��������ΪX2
% zlabel( 'Frequency' );         	%��ά������x��������ΪFrequency��Ƶ����
% 
% subplot(1,2,2);                 %��ͼ2���������������Ƶ���ֲ�ֱ��ͼ
% samples = sample(:,:);
% hist3(samples','Edges',{xx1,xx2});%����������Ƶ���ֲ�ֱ��ͼ
% xlabel('X1');                   %��ά������x��������ΪX1
% ylabel('X2' );                  %��ά������x��������ΪX2
% zlabel( 'Frequency' );         	%��ά������x��������ΪFrequency��Ƶ����
end