clear all,close all,clc;

load('train.mat');          %����ѵ������
%% RBM��ʼ��
opts.numepochs =   1;
opts.batchsize = 100;
opts.momentum  =   0;
opts.alpha     =   1;
training_data = MNIST_for_log;

%% ѵ��10��hidden unit��RBM
dbn.sizes = 10;
dbn = dbnsetup(dbn, training_data, opts);
dbn = dbntrain(dbn, training_data, opts);
parameter_W = dbn.rbm{1,1}.W';
parameter_a = dbn.rbm{1,1}.c';
parameter_b = dbn.rbm{1,1}.b';
save('trained_h10.mat','parameter_W','parameter_a','parameter_b');

%% ѵ��20��hidden unit��RBM
dbn.sizes = 20;
dbn = dbnsetup(dbn, training_data, opts);
dbn = dbntrain(dbn, training_data, opts);
parameter_W = dbn.rbm{1,1}.W';
parameter_a = dbn.rbm{1,1}.c';
parameter_b = dbn.rbm{1,1}.b';
save('trained_h20.mat','parameter_W','parameter_a','parameter_b');

%% ѵ��100��hidden unit��RBM
dbn.sizes = 100;
dbn = dbnsetup(dbn, training_data, opts);
dbn = dbntrain(dbn, training_data, opts);
parameter_W = dbn.rbm{1,1}.W';
parameter_a = dbn.rbm{1,1}.c';
parameter_b = dbn.rbm{1,1}.b';
save('trained_h100.mat','parameter_W','parameter_a','parameter_b');

%% ѵ��500��hidden unit��RBM
dbn.sizes = 500;
dbn = dbnsetup(dbn, training_data, opts);
dbn = dbntrain(dbn, training_data, opts);
parameter_W = dbn.rbm{1,1}.W';
parameter_a = dbn.rbm{1,1}.c';
parameter_b = dbn.rbm{1,1}.b';
save('trained_h500.mat','parameter_W','parameter_a','parameter_b');