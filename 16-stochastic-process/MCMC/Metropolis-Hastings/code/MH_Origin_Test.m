clear all,close all,clc;
num_run = 100;
R = zeros(1,num_run);
SE = zeros(1,num_run);
for i = 1:num_run
    R(i) = MH_Origin();
end
SE = (R-0.5).^2;
figure(1);
plot(R);
ylim([0,1]);
title('MH�㷨�������ϵ�����(δ���в����ĵ���)');
xlabel('MH�㷨���д���');
ylabel('���ϵ������ֵ');
figure(2);
plot(SE);
title('MH�㷨�������ϵ�� ������(δ���в����ĵ���)');
xlabel('MH�㷨���д���');
ylabel('���ϵ������ֵ����ʵֵ�����');
