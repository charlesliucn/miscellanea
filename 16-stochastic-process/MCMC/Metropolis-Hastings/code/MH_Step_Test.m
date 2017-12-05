clear all,close all,clc;

N = 50;
step = [1,3,5,7,10];
R = zeros(5,N);
for i = 1:5
    for j = 1:N
        R(i,j) = MH_Step(step(i));
    end
end
plot(R(1,:),'k.');hold on;
plot(R(2,:),'b:');hold on;
plot(R(3,:),'r-');hold on;
plot(R(4,:),'m');hold on;
plot(R(5,:),'r*');hold on;
ylim([0,1]);
legend(sprintf('step = 1'),sprintf('step = 3'),...
    sprintf('step = 5'),sprintf('step = 7'),...
    sprintf('step = 10'));
title('���ϵ������ֵ�ĸ��� �� ѡȡ��������Ĳ���(step) �Ĺ�ϵ');
xlabel('���д���');
ylabel('���ϵ������ֵ');
    