%suffix t refers to train, suffix s refers to test
more off;
clear all;
close all;

start=tic;
fprintf('loading data\n'); 
load('mnist_all.mat');
xxt=[train0; train1; train2; train3; train4; train5; train6; train7; train8; train9];
xxs=[test0; test1; test2; test3; test4; test5; test6; test7; test8; test9];
kt=single(xxt)/255;
ks=single(xxs)/255;
[n,d]=size(kt);
m=size(ks,1);
k=10;
yt=zeros(n,k);
ys=zeros(m,k);
Ik=eye(k);
lt=1; 
ls=1;
for i=1:k; 
    st=size(eval(sprintf('train%d',i-1)),1);
    yt(lt:lt+st-1,:)=repmat(Ik(i,:),st,1); 
    lt=lt+st;
    ss=size(eval(sprintf('test%d',i-1)),1);
    ys(ls:ls+ss-1,:)=repmat(Ik(i,:),ss,1); 
    ls=ls+ss;
end
clear i st ss ls lt I10 xxt xxs train* test*
toc(start);

fprintf('\n==Single layer GEM==\n'); 
fprintf('learning features\n'); 
[trainx,testx]=gem(kt,ks,yt); 
toc(start);
fprintf('fitting model\n'); 
ps=cls(trainx,yt,testx,0.5,7);
toc(start);
showconfusion(ps,ys);

fprintf('\n==Deep GEM==\n'); 
fprintf('learning features\n');
[trainx,testx]=deepgem(kt,ks,yt);
toc(start);
fprintf('fitting model\n'); 
ps=cls(trainx,yt,testx,1,5);
toc(start);
showconfusion(ps,ys);


