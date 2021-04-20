function []=slenet_lenet0b_poisson_prob()
load raw_avg_0b_poisson.mat analysis_avg_0b
load labels.mat labels
load test_0bias.mat test_0bias
load fitresult_avg0b_poisson.mat fitresult
initime=302-size(fitresult,2);
acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.01)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.01.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.01');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.01');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.01');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.01');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.001');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.0001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.0001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.0001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.0001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.0001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.0001');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.00001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.00001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.00001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.00001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.00001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.00001');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.000001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.000001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.000001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.000001');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.0000001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.0000001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.0000001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.0000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.0000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.0000001');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.00000001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.00000001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.00000001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.00000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.00000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.00000001');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.000000001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.000000001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.000000001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.000000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.000000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.000000001');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.0000000001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.0000000001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.0000000001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.0000000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.0000000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.0000000001');

acc_req=zeros(300,1);
time_req=zeros(300,1);
err_req=zeros(300,1);
err_tmax=zeros(300,1);
for n=1:1:10000
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,1)=acc_req(time,1)+accr;
                err_req(time,1)=err_req(time,1)+err;
                time_req(time,1)=time_req(time,1)+acttime;
            else
                max1=0;max2=0;
                for ii=1:1:10
                    if analysis_avg_0b(time,ii,n)>max1
                        max2=0;
                        max1=analysis_avg_0b(time,ii,n);
                    else
                        if analysis_avg_0b(time,ii,n)>max2
                            max2=analysis_avg_0b(time,ii,n);
                        end
                    end
                end
                if time>=initime
                miu=fitresult(time,max1+1,1)-fitresult(time,max2+1,1);
                sigma=sqrt(fitresult(time,max1+1,2)*fitresult(time,max1+1,2)+fitresult(time,max2+1,2)*fitresult(time,max2+1,2));
                scale=miu/sigma;
                else
                    scale=0;
                end
                if (time>=initime) && (normcdf(-scale,0,1)<=0.00000000001)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>max1
                            max1=analysis_avg_0b(time,ii,n);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    if maxid==test_0bias(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,1)=acc_req(time,1)+accr;
                    err_req(time,1)=err_req(time,1)+err;
                    time_req(time,1)=time_req(time,1)+acttime;
                else
                    time_req(time,1)=time_req(time,1)+time;

                    maxcount=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)>maxcount
                            maxcount=analysis_avg_0b(time,ii,n);
                        end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if analysis_avg_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,1)=acc_req(time,1)+1/10000;
                        end
                        if maxids(r(ii,1),1)~=test_0bias(1,n)
                            err_tmax(time,1)=err_tmax(time,1)+1/10000;
                        end
                    end
                end
            end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
save lenet0b_poisson_prob_0.00000000001.mat acc_req time_req err_req err_tmax
xlswrite('lenet0b_poisson_prob.xlsx',acc_req,'acc_0.00000000001');
xlswrite('lenet0b_poisson_prob.xlsx',time_req,'time_0.00000000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_req,'err_req_0.00000000001');
xlswrite('lenet0b_poisson_prob.xlsx',err_tmax,'err_tmax_0.00000000001');
end