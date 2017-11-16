function B= mydct2(A)
% ��ά��ɢ���ұ任����
% ���룺��ά����A
% ����ֵ��A�Ķ�ά��ɢ���ұ任B
% B = DCTtwo(A) ���ؾ���A�Ķ�ά��ɢ���ұ任������B�;���A��С��ͬ

    [M,N]=size(A);      %��ȡ����A�Ĵ�С
    B=zeros(M,N);       %��ʼ�����ؾ���B
    D=zeros(M,N);       %��ʼ��DCT���Ӿ���
    for i=1:M
        for j=1:N
            %DCT���ӵ�Ԫ�ؼ��㹫ʽ
        	D(i,j)=sqrt(2/M)*cos((i-1)*(2*j-1)*pi/(2*M));
        end
    end
    D(1,:)=D(1,:)/sqrt(2);  %ϵ���������
    B=D*A*D';               %ֱ�Ӹ��ݾ�������
    
end
