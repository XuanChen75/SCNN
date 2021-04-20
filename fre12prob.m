load frequency.mat frequency12
duo=zeros(300,300);
shao=zeros(300,300);
for time=1:1:300
    for ii=1:1:time+1
        for jj=1:1:ii-1
            req=ii-jj;
            for kk=1:1:req
                duo(time,kk)=duo(time,kk)+frequency12(time,ii,jj);
                shao(time,kk)=shao(time,kk)+frequency12(time,jj,ii);
            end
        end
    end
    for kk=1:1:time
        if (duo(time,kk)+shao(time,kk))~=0
            prob(time,kk)=duo(time,kk)/(duo(time,kk)+shao(time,kk));
        else
            prob(time,kk)=0;
        end
    end
end
save fre12prob.mat prob
                