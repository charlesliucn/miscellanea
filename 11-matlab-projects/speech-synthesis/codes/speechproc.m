function speechproc()

    % ���峣��
    FL = 80;                % ֡��
    WL = 240;               % ����
    P = 10;                 % Ԥ��ϵ������
    s = readspeech('voice.pcm',100000);             % ��������s
    L = length(s);          % ������������
    FN = floor(L/FL)-2;     % ����֡��
    
    % Ԥ����ؽ��˲���
    exc = zeros(L,1);       % �����źţ�Ԥ����
    zi_pre = zeros(P,1);    % Ԥ���˲�����״̬
    s_rec = zeros(L,1);     % �ؽ�����
    zi_rec = zeros(P,1);    % �ؽ��������˲���״̬
    zi_syn = zeros(P,1);    % �ϳ��������˲���״̬
    zi_syn_v = zeros(P,1);  % ���ٲ�����ĺϳ��������˲���״̬
    zi_syn_t = zeros(P,1);  % ��������ٵĺϳ��������˲���״̬
    
    % �ϳ��˲���
    exc_syn = zeros(L,1);   % �ϳɵļ����źţ����崮��
    s_syn = zeros(L,1);     % �ϳ�����
    % ����������˲���
    exc_syn_t = zeros(L,1);   % �ϳɵļ����źţ����崮��
    s_syn_t = zeros(L,1);     % �ϳ�����
    % ���ٲ�����˲����������ٶȼ���һ����
    exc_syn_v = zeros(2*L,1);   % �ϳɵļ����źţ����崮��
    s_syn_v = zeros(2*L,1);     % �ϳ�����

    hw = hamming(WL);       % ������
    
    % ���δ���ÿ֡����
    for n = 3:FN

        % ����Ԥ��ϵ��������Ҫ���գ�
        s_w = s(n*FL-WL+1:n*FL).*hw;    %��������Ȩ�������
        [A E] = lpc(s_w, P);            %������Ԥ�ⷨ����P��Ԥ��ϵ��
                                        % A��Ԥ��ϵ����E�ᱻ��������ϳɼ���������

        if n == 27
        % (3) �ڴ�λ��д���򣬹۲�Ԥ��ϵͳ���㼫��ͼ
           a_pre=A;                     %���������ź�ϵ����Ԥ��ϵ����
           b_pre=[1];                   %��������ź�ϵ����1��
           zplane(b_pre,a_pre);         %zplane�����㼫��ֲ�ͼ
           title('Ԥ��ϵͳ���㼫��ֲ�ͼ');    %��ͼ
        end
        
        s_f = s((n-1)*FL+1:n*FL);       % ��֡�����������Ҫ����������

        % (4) �ڴ�λ��д������filter����s_f���㼤����ע�Ᵽ���˲���״̬
        [exc((n-1)*FL+1:n*FL),zf_pre]=filter(A,1,s_f,zi_pre);
        zi_pre=zf_pre;                  % �����˲���״̬


        % (5) �ڴ�λ��д������filter������exc�ؽ�������ע�Ᵽ���˲���״̬
        [s_rec((n-1)*FL+1:n*FL),zf_rec]=filter(1,A,exc((n-1)*FL+1:n*FL),zi_rec);
        zi_rec=zf_rec;                  % �����˲���״̬
  

        % ע������ֻ���ڵõ�exc��Ż������ȷ
        s_Pitch = exc(n*FL-222:n*FL);
        PT = findpitch(s_Pitch);    % �����������PT����Ҫ�����գ�
        G = sqrt(E*PT);           % ����ϳɼ���������G����Ҫ�����գ�

        
        % (10) �ڴ�λ��д�������ɺϳɼ��������ü�����filter���������ϳ�����
        
        pos_syn=2*FL+1;                 %���ڴӵ�3֡��ʼ����n=3ʱ�������źŴ�2*FL+1��n*FL
        while(pos_syn<=n*FL)            %����9.2.2��2���еĻ������ڴ�����
            exc_syn(pos_syn)=G;         %GΪ����õ�������
            pos_syn=pos_syn+PT;        	%����ÿ����ÿ�������ǰһ������ļ��Ϊ���ε�PTֵ
        end
        Gxn=exc_syn((n-1)*FL+1:n*FL);	%Gxn��exc_synΪ�ϳɵļ����ź�
        [sn_syn,zf_syn]=filter(1,A,Gxn,zi_syn);     %AΪԤ��ϵ��
        zi_syn=zf_syn;                  %�����˲���״̬�������ı�
        s_syn((n-1)*FL+1:n*FL)=sn_syn;	%�ϳ�����~s(n)


        % (11) ���ı�������ں�Ԥ��ϵ�������ϳɼ����ĳ�������һ��������Ϊfilter
        % ������õ��µĺϳ���������һ���ǲ����ٶȱ����ˣ�������û�б䡣
        
        pos_syn_v=2*FL+1;          %���ڴӵ�3֡��ʼ����n=3ʱ�������źŴ�2*FL+1��n*FL
        while(pos_syn_v<=2*n*FL)   %����9.2.2��2���еĻ������ڴ��������ܳ���Ϊԭ����2��
            exc_syn_v(pos_syn_v)=G;%GΪ����õ�������
            pos_syn_v=pos_syn_v+PT;%ͬ������ÿ����ÿ�������ǰһ������ļ��Ϊ���ε�PTֵ
        end
        Gxn_t=exc_syn_v(2*(n-1)*FL+1:2*n*FL);	%Gxn_v��exc_syn_vΪ�ϳɵļ����ź�
        [sn_syn_v,zf_syn_v]=filter(1,A,Gxn_t,zi_syn_v);     %AΪԤ��ϵ��
        zi_syn_v=zf_syn_v;         %�����˲���״̬�������ı�
        s_syn_v(2*(n-1)*FL+1:2*n*FL)=sn_syn_v;	%�ϳ�����s_syn_v   
     

        
        %(13)���������ڼ�Сһ�룬�������Ƶ������150Hz�����ºϳ�������������ɶ���ܡ�
        
            [z,p,k]=tf2zp(1,A);         %��⣨1)����
            fs=8000;                    %����Ƶ��ȡ8000Hz
            delta_omg=2*pi*150*sign(angle(p))/fs;  %�Ƶ��Ĺ�ʽ�еġ�����
            pn=p.*exp(1i*delta_omg);               %�õ�����������¼���
            [Bc,Ac]=zp2tf(z,pn,k);                 %��zp2tf�����õ�ϵ������A,B
            pos_syn_t=2*FL+1;          %�ӵ�3֡��ʼ���������źŴ�2*FL+1��n*FL
            while(pos_syn_t<=n*FL)     %�������ڴ��������ܳ���Ϊԭ����2��
                exc_syn_t(pos_syn_t)=G;%GΪ����õ�������
                pos_syn_t=pos_syn_t+round(PT/2);%ÿ����ÿ�������ǰһ������Ϊ����PT
            end
            Gxn_t=exc_syn_t((n-1)*FL+1:n*FL);	%Gxn_t��exc_syn_tΪ�ϳɵļ����ź�
            [sn_syn_t,zf_syn_t]=filter(Bc,Ac,Gxn_t,zi_syn_t);   %AΪԤ��ϵ��
            zi_syn_t=zf_syn_t;     %�����˲���״̬�������ı�
            s_syn_t((n-1)*FL+1:n*FL)=sn_syn_t;	%�ϳ�����s_syn_t
        
    end

    % (6) �ڴ�λ��д������һ�� s ��exc �� s_rec �к����𣬽�����������
    % ��������������ĿҲ������������д���������ر�ע��
    figure;
    subplot(3,1,1); plot(s);        %������s(n)�ź�
    subplot(3,1,2); plot(exc);      %������e(n)�ź�
    subplot(3,1,3); plot(s_rec);    %������s^(n)�ź�
    
    figure;
    sound(s);                       %��������ֱ�Ӵ�voice.pcm����������ź�s(n)
    subplot(3,1,1);                 %��ͼ1
    plot(s(0.3*L:0.5*L));           %ѡȡ����������0.3~0.5����
    title('s(n)�ź�');              %���ñ���
    pause(2);                       %ͣ��2s,������������
    sound(exc);                     %����֮ǰ�õ��ļ����ź�e(n)
    subplot(3,1,2);                 %��ͼ2
    plot(exc(0.3*L:0.5*L));         %ѡȡ����������0.3~0.5����
    title('e(n)�ź�');              %���ñ���
    pause(2);                       %ͣ��2s,������������
    sound(s_rec);                   %�����ɼ����ź�e(n)�ָ��������ź�s^(n)
    subplot(3,1,3);                 %��ͼ3
    plot(s_rec(0.3*L:0.5*L));       %ѡȡ����������0.3~0.5����
    title('s''(n)�ź�');            %���ñ���
    
    pause(2);
    sound(s_syn);                   %����(10)�ĺϳ�����
   %figure;subplot(2,1,1);plot(s);subplot(2,1,2);plot(s_syn);
    pause(2);
    sound(s_syn_v);                 %����(11)���ٲ�����ĺϳ�����
   %figure;subplot(2,1,1);plot(s);subplot(2,1,2);plot(s_syn_v);
    pause(4);
    sound(s_syn_t);                 %����(13)��������ٵĺϳ�����
   %figure;subplot(2,1,1);plot(s);subplot(2,1,2);plot(s_syn_t);
    
    
    % ���������ļ�
    writespeech('exc.pcm',exc);
    writespeech('rec.pcm',s_rec);
    writespeech('exc_syn.pcm',exc_syn);
    writespeech('syn.pcm',s_syn);
    writespeech('exc_syn_t.pcm',exc_syn_t);
    writespeech('syn_t.pcm',s_syn_t);
    writespeech('exc_syn_v.pcm',exc_syn_v);
    writespeech('syn_v.pcm',s_syn_v);
return

% ��PCM�ļ��ж�������
function s = readspeech(filename, L)
    fid = fopen(filename, 'r');
    s = fread(fid, L, 'int16');
    fclose(fid);
return

% д������PCM�ļ���
function writespeech(filename,s)
    fid = fopen(filename,'w');
    fwrite(fid, s, 'int16');
    fclose(fid);
return

% ����һ�������Ļ������ڣ���Ҫ������
function PT = findpitch(s)
    [B, A] = butter(5, 700/4000);
    s = filter(B,A,s);
    R = zeros(143,1);
    for k=1:143
        R(k) = s(144:223)'*s(144-k:223-k);
    end
    [R1,T1] = max(R(80:143));
    T1 = T1 + 79;
    R1 = R1/(norm(s(144-T1:223-T1))+1);
    [R2,T2] = max(R(40:79));
    T2 = T2 + 39;
    R2 = R2/(norm(s(144-T2:223-T2))+1);
    [R3,T3] = max(R(20:39));
    T3 = T3 + 19;
    R3 = R3/(norm(s(144-T3:223-T3))+1);
    Top = T1;
    Rop = R1;
    if R2 >= 0.85*Rop
        Rop = R2;
        Top = T2;
    end
    if R3 > 0.85*Rop
        Rop = R3;
        Top = T3;
    end
    PT = Top;
return