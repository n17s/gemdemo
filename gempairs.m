function filters=gempairs(kt,yt,gamma,threshold,top)
    [n,k]=size(yt);
    [~,d]=size(kt);
    covs=zeros(d,d,k);
    for i=1:k
        ind=find(yt(:,i)==1);
        kind=kt(ind,:);
        ni=length(ind);
        covs(:,:,i)=double(kind'*kind)/ni;
        clear ind kind;
    end

    filters=zeros(d,top*k*(k-1),'single');
    last=0;
    
    for j=1:k
        covj=squeeze(covs(:,:,j)); l=chol(covj+gamma*speye(d),'lower');
        for i=1:k
            if j~=i
                covi=squeeze(covs(:,:,i));
                C=l\covi/l'; CS=0.5*(C+C'); [V,L]=eigs(CS,top);
                take=find(diag(L)>=threshold);
                batch=length(take);
                fprintf('%u,%u,%u ', i, j, batch);
                filters(:,last+1:last+batch)=l'\V(:,take);
                last=last+batch;
            end
        end
        fprintf('\n');
    end
    fprintf('gamma=%g,top=%u,threshold=%g\n',gamma,top,threshold);
    fprintf('last=%u filtered=%u\n', last, size(filters,2) - last);
    clear covi covj covs C CS V L
    filters=filters(:,1:last);
end