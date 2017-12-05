%function R = MH_Gibbs()

u1 = 5;         %E(X1) = 5;
u2 = 10;        %E(X2) = 10;
sigma1 = 1;     %Var(X1) = 1;
sigma2 = 2;     %Var(X2) = 4;
cov = 1;        %Э����Cov(X1,X2)Ϊ1
realr = cov/(sigma1*sigma2);    %rΪ���ϵ��

N = 100000;          %���������������ΪN
sample = zeros(2,N);%���ڱ������ɵ������������һ�д洢x1,�ڶ��д洢��Ӧ��x2

%��˹�ֲ���ΧΪ���������Ҫѡ��һ�����ʴ�С�ķ�Χ
x1_range = [0,10];      %x1�ķ�Χ
x2_range = [0,20];  	%x2�ķ�Χ

n = 1;                  %n���ڼ�¼���������������ʼ��Ϊ1
%��������ɵĳ�ֵ�����һ���������
sample(1,n) = unifrnd(x1_range(1),x1_range(2));    %ʹ��unifrnd��x1��ȡֵ��Χ��ѡȡ��ֵx1_start
sample(2,n) = unifrnd(x2_range(1),x2_range(2));    %ʹ��unifrnd��x2��ȡֵ��Χ��ѡȡ��ֵx2_start

%%Metropolis-Hastings�㷨�����������
for n = 1:N-1 
    u1_new = u1+realr*(sample(2,n)-u2);
    sigma_new = sqrt(1-realr^2);
    sample(1,n+1) = normrnd(u1_new,sigma_new);
    u2_new = u2+realr*(sample(1,n+1)-u1);
    sample(2,n+1) = normrnd(u2_new,sigma_new);
end

%���ݲ���������������ƶ�ά��˹�ֲ������ϵ��
X1 = sample(1,:);               %��������е�X1
X2 = sample(2,:);               %��������е�X2
L = length(X1);
E1 = sum(X1)/L;                 %X1�ľ�ֵ
E2 = sum(X2)/L;                 %X2�ľ�ֵ
Var1 = sum((X1-E1).^2)/L;       %X1����������
Var2 = sum((X2-E2).^2)/L;       %X2����������
E12 = sum(X1.*X2)/L;            %������������E(X1X2)
Cov= E12-E1*E2;                 %����Э����
R = Cov/sqrt(Var1*Var2);        %�õ����ϵ��

subplot(1,2,1);                 %��ͼ1��������ʵ�ֲ�ͼ
num = 100;                      %ÿ������Χ�ֵĶ���
xx1 = linspace(x1_range(1),x1_range(2),num); %��x1�����Ϊnum��
xx2 = linspace(x2_range(1),x2_range(2),num); %��x2�����Ϊnum��
[x1g,x2g] = meshgrid(xx1,xx2);  %���ɾ��󣬾�������
f = bigauss(x1g,x2g);           %�������˹�ֲ��ڸ���ĸ����ܶ�
surf(x1g,x2g,f);                %���������ܶȷֲ�ͼ
xlabel('X1');                   %��ά������x��������ΪX1
ylabel('X2' );                  %��ά������x��������ΪX2
zlabel( 'Frequency' );         	%��ά������x��������ΪFrequency��Ƶ����

subplot(1,2,2);                 %��ͼ2���������������Ƶ���ֲ�ֱ��ͼ
hist3(sample','Edges',{xx1,xx2});%����������Ƶ���ֲ�ֱ��ͼ
xlabel('X1');                   %��ά������x��������ΪX1
ylabel('X2' );                  %��ά������x��������ΪX2
zlabel( 'Frequency' );         	%��ά������x��������ΪFrequency��Ƶ����
%end