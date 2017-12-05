clear all,close all,clc;

Sample_Num = [100,1000,10000,100000];
len = length(Sample_Num);
Times = 50;
R = zeros(len,Times);
for i = 1:len
    for j = 1:Times
        R(i,j) = MH_Sample_Num(Sample_Num(i));
    end
end
plot(R(1,:),'r:');hold on;
plot(R(2,:),'b');hold on;
plot(R(3,:),'k-');hold on;
plot(R(4,:),'m*');hold on;
ylim([0,1]);
legend(sprintf('���������N = 100'),sprintf('���������N = 1000'),...
    sprintf('���������N = 10000'),sprintf('���������N = 100000'));
title('���ϵ������ֵ�ĸ��� �� ���������Ŀ �Ĺ�ϵ');
xlabel('���д���');
ylabel('���ϵ������ֵ');
