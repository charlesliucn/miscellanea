function img_mean = meanfilter(img,n)
% �������ܣ���ͼ����о�ֵ�˲�(ģ�����)
% ����:
%       img:        ����ͼ��
%       n:          ѡ��ģ��ߴ�(����Ϊ����)
% ���:
%       img_mean:   ��ֵ�˲����ͼ��

    if(mod(n,2) == 0)           % Ҫ��ģ��ߴ�(�߳�)Ϊ����
        error('ģ��߳�Ҫ��Ϊ����!');
    end
    [height,width] = size(img); % ��ȡ����ͼ��ߴ�
    template = uint8(ones(n));  % ����ģ��
    tempsize = n*n;             % ģ���С
    r = (n-1)/2;                % ����ģ��뾶
    
    %% ʹ�öԳƷ���ͼ���С������չ�����ڽ���ģ�����
    img_temp = [img(:,r:-1:1),img,img(:,width:-1:width-r+1)];                   % ������չ
    img_sym = [img_temp(r:-1:1,:);img_temp;img_temp(height:-1:height-r+1,:)];   % ������չ
    %% ��ֵ�˲�ģ�����
    for i = 1:height
        for j = 1:width
            m = i+r; n = j+r;
            img(i,j) = sum(sum(img_sym(m-r:m+r,n-r:n+r).*template))/tempsize;   % ����ģ���ڵľ�ֵ
        end
    end
    %% ���ؾ�ֵ�˲����ͼ��
    img_mean = uint8(img);
end