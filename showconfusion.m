function showconfusion(ps,ys)
    [~,k]=size(ys);
    [~,testy]=max(ys,[],2);
    [~,yhats]=max(ps,[],2); 
    total=0;
    fprintf('%4s\t', 'pred');
    for truey=1:k
            fprintf('%5u', truey-1);
    end
    fprintf('%5s\n%4s\n', '!=', 'true');
    for truey=1:k
            fprintf('%4u\t', truey-1);
            trueidx=find(testy==truey);
            for predicted=1:k
                    predidx=find(yhats(trueidx)==predicted);
                    fprintf('%5u', sum(predidx>0));
            end
            predidx=find(yhats(trueidx)~=truey);
            fprintf('%5u\n', sum(predidx>0));
            total = total + sum(predidx>0);
    end
    fprintf('%u total errors\n',total);
end