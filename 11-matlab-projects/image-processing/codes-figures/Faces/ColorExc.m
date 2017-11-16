function [u] = ColorExc(L,Face)
% �������ܣ���ȡͼ�����ɫ����
% ���룺    L���ں�����ɫ����������Face��ͼ�����
% ����ֵ��  ��ɫ���������ֲ�ͬ��ɫ�ı������ɵ�ʸ��
    
    [width,len,dim]=size(Face);
    pixelnum=width*len;
    colornum=2^(3*L);
    adder=1/pixelnum;
    u=zeros(1,colornum);
    for i=1:width
        for j=1:len
            Color=double(Face(i,j,:));
            Color=floor(Color/2^(8-L));
            n=1+2^(2*L)*Color(1)+2^L*Color(2)+Color(3);
            u(n)=u(n)+adder;
        end
    end
end