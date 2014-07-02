function [trainx,testx]=deepgem(kt,ks,yt)
    [n,~]=size(yt);
    [m,~]=size(ks);
    gamma=0.1;
    top=20;
    threshold=0;
    filters=gempairs(kt,yt,gamma,threshold,top);
    % NB: augmenting kt/ks with .^2 terms is very slow and doesn't help
    ft=kt*filters;
    clear kt;
    kt=[ones(n,1,'single') sqrt(1+max(ft,0))-1 sqrt(1+max(-ft,0))-1];
    clear ft;
    fs=ks*filters;
    clear ks filters;
    ks=[ones(m,1,'single') sqrt(1+max(fs,0))-1 sqrt(1+max(-fs,0))-1];
    clear fs;
    
    threshold2=7.5;
    filters=gempairs(kt,yt,gamma,threshold2,top);
    ft=kt*filters;
    clear kt;
    kt=[sqrt(1+max(ft,0))-1 sqrt(1+max(-ft,0))-1];
    clear ft;
    fs=ks*filters;
    clear ks filters;
    ks=[sqrt(1+max(fs,0))-1 sqrt(1+max(-fs,0))-1];
    clear fs;

    trainx=[ones(n,1,'single') kt kt.^2];
    clear kt;
    testx=[ones(m,1,'single') ks ks.^2];
    clear ks;
end