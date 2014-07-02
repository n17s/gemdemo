function [trainx,testx]=gem(kt,ks,yt)
    [n,~]=size(yt);
    [m,~]=size(ks);
    gamma=0.05;
    top=30;
    threshold=2.5;
    filters=gempairs(kt,yt,gamma,threshold,top);

    ft=kt*filters;
    rawtrainx=[kt sqrt(1+max(ft,0))-1 sqrt(1+max(-ft,0))-1];
    clear kt ft;
    trainx=[ones(n,1,'single') rawtrainx rawtrainx.^2 rawtrainx.^3];
    clear rawtrainx;

    fs=ks*filters;
    rawtestx=[ks sqrt(1+max(fs,0))-1 sqrt(1+max(-fs,0))-1];
    clear ks fs;
    testx=[ones(m,1,'single') rawtestx rawtestx.^2 rawtestx.^3];
    clear rawtestx;
end