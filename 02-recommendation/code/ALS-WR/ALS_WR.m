function [U, V] = ALS_WR(traindata,testdata,M,d,lambda,Iterations)
% ʹ��ALS_WR�㷨����U��V

[nuser,nitem] = size(M);
[usridx,itmidx] = find(M);                              % ѵ�������з��������index(user index��item index)
% �������ǰ��ʼ��
U = zeros(nuser,d);                                     % U�����ʼ��
V = rand(nitem,d);                                      % V�����ʼ��

% ��ʼ��������
for iter = 1:Iterations
    % �̶�����V�����¾���U��ÿһ��
    for i = 1:nuser                                     % ����ÿһ��user
        logic = (usridx == i);                          % ����һ���߼�������
        if(nnz(logic) > 0)                           	% �������и�user������
            items = itmidx(logic);                   	% ��user��Ӧ�Ĵ�ֵ�item
            Vs = V(items,:);                            % ��ѡ������ֵ�item��Ϊһ���µ�(С)����
            nitem_i = nnz(M(i,items));                  % �û�i�����۵�item������
            A = Vs'*Vs + lambda * nitem_i * eye(d);    % ���������ʽpart1
            T = Vs' * M(i,items)';                      % ���������ʽpart2
            U(i,:) = A\T;                               % ���㷨�к��Ĺ�ʽ
        else
            U(i,:) = zeros(1,d);                        % ������û�û�д�֣�����Ϊ0����
        end;
    end;
    % �̶�����U�����¾���V��ÿһ��
    for j = 1:nitem                                     % ����ÿһ��item
        logic = (itmidx == j);                          % ����һ���߼�������
        if(nnz(logic) > 0)                              % ����item���ܵ�����
            users = usridx(logic);                      % ������۵�����user
            Us = U(users,:);                            % ��ѡ������ֵ�user��Ϊһ���µ�(С)����
            nuser_i = nnz(M(users,j));                  % item���ܵ�����������
            A = (Us' * Us) + lambda * nuser_i * eye(d); % ���������ʽpart1
            T = Us' * M(users,j);                       % ���������ʽpart2
            V(j,:) = A\T;                               % ���㷨�к��Ĺ�ʽ
        else
            V(j,:) = zeros(1,d);                        % �����itemû���ܵ����ۣ�����Ϊ0����
        end;
    end;
    % �����������õ�����U��V
    X = U*V';
    [trainMSE,testMSE] = calcMSE(traindata,testdata,X);
    fprintf('Iteration %d -- trainMSE %f | testMSE %f\n',iter, trainMSE, testMSE);
end
