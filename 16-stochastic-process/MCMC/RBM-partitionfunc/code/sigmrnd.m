function X = sigmrnd(P)
%���ɻ���Sigmoid�����������

    X = double(1./(1+exp(-P)) > rand(size(P)));
end