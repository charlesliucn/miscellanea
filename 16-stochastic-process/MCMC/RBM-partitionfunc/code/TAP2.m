function TAP_LogConst = TAP2(W, a, b) 
% TAP(Thouless-Anderson-Palmer)�㷨����RBM��һ������(ѡ����׽���)
% ���룺
%   W�� ���ز㵥Ԫ�Ϳɼ��㵥Ԫ��Ȩ�ع��ɵľ���
%   a�� ���ز㵥Ԫ��bias��
%   b�� �ɼ��㵥Ԫ��bias��
% �����
%   TAP_LogConst��TAP�㷨(����)�õ��Ĺ�һ����������ֵ.

%% ׼������
[num_vis,num_hid] = size(W); 	%��Ȩ�ؾ����ȡ���ز�Ϳɼ����unit��
if(num_hid < 100)
    mv = 1./(1+exp(-b))';
    mh = 1./(1+exp(-a))';
else
    mv = randn(num_vis,1);      	%��ʼ��mv
    mh = randn(num_hid,1);          %��ʼ��mh
end
%% TAP�㷨�����׽��ƣ�
flag = 0;                    	%�����ж��Ƿ������ı�־
while(flag == 0)
     %������ʽ�и��µõ�mh_next ��ʽ9
     update_h = a'+W'*mv+(W.^2)'*(mv-mv.^2).*(mh-0.5);
     one_h = ones(num_hid,1);
     mh_next = one_h./(1+exp(-update_h));
     
     %������ʽ���µõ�mv_next ��ʽ10
     update_v = b'+W*mh_next+(W.^2)*(mh_next-mh_next.^2).*(mv - 0.5);
     one_v = ones(num_vis,1);
     mv_next = one_v./(1+exp(-update_v));
     
     %�ж��Ƿ�����
     if(max(abs(mh - mh_next)) == 0 && max(abs(mv - mv_next) == 0))
         flag = 1;
     else
        %�õ����º�Ľ��
    	mh = mh_next;
        mv = mv_next;
     end
 end
 
%% TAP�㷨(���׽��ƣ�
S1 = - sum(mv.*log(mv) + (1-mv).*log(1-mv));    % mv����(entropy)
S2 = - sum(log(mh.^mh)+log((1-mh).^(1-mh)));    % mh����(entropy)
TAP_LogConst = S1 + S2 + sum(b'.*mv) + sum(a'.*mh) + mv'*W*mh + 0.5*((W.^2)'*(mv-mv.^2))'*(mh-mh.^2); %��ʽ7�����һ������

end