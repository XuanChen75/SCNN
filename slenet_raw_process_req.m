function []=slenet_raw_process_req()
%load raw_avg_0b_poisson.mat analysis_avg_0b
load raw_avg_bn.mat analysis_avg_bn
%load raw_max_0b.mat analysis_max_0b
load labels.mat labels
%load test_0bias.mat test_0bias
load test_lenetbn.mat test_lenetbn
%load test_0bias_max.mat test_0bias_max
acc_req=zeros(300,10);
time_req=zeros(300,10);
err_req=zeros(300,10);

    
for n=1:1:10000
    deltacount=zeros(300,1);
    for time=1:1:300
        max1=0;max2=0;
        for ii=1:1:10
            %if analysis_avg_0b(time,ii,n)>max1
            %    max2=0;
            %    max1=analysis_avg_0b(time,ii,n);
            %else
            %    if analysis_avg_0b(time,ii,n)>max2
            %        max2=analysis_avg_0b(time,ii,n);
            %    end
            %end
            if analysis_avg_bn(time,ii,n)>max1
                max2=0;
                max1=analysis_avg_bn(time,ii,n);
            else
                if analysis_avg_bn(time,ii,n)>max2
                    max2=analysis_avg_bn(time,ii,n);
                end
            end
            %if analysis_max_0b(time,ii,n)>max1
            %    max2=0;
            %    max1=analysis_max_0b(time,ii,n);
            %else
            %    if analysis_max_0b(time,ii,n)>max2
            %        max2=analysis_max_0b(time,ii,n);
            %    end
            %end
        end
        deltacount(time,1)=max1-max2;
    end
    for req=1:1:10
        flag=0;acttime=0;accr=0;err=0;
        for time=1:1:300
            if flag==1
                acc_req(time,req)=acc_req(time,req)+accr;
                err_req(time,req)=err_req(time,req)+err;
                time_req(time,req)=time_req(time,req)+acttime;
            else
                if deltacount(time,1)>=req+20
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        %if analysis_avg_0b(time,ii,n)>max1
                        %    max1=analysis_avg_0b(time,ii,n);
                        %    maxid=ii-1;
                        %end
                        if analysis_avg_bn(time,ii,n)>max1
                            max1=analysis_avg_bn(time,ii,n);
                            maxid=ii-1;
                        end
                        %if analysis_max_0b(time,ii,n)>max1
                        %    max1=analysis_max_0b(time,ii,n);
                        %    maxid=ii-1;
                        %end
                    end
                    if maxid==labels(1,n)
                        accr=1;
                    else
                        accr=0;
                    end
                    %if maxid==test_0bias(1,n)
                    if maxid==test_lenetbn(1,n)
                    %if maxid==test_0bias_max(1,n)
                        err=0;
                    else
                        err=1;
                    end
                    acc_req(time,req)=acc_req(time,req)+accr;
                    err_req(time,req)=err_req(time,req)+err;
                    time_req(time,req)=time_req(time,req)+acttime;
                else
                    time_req(time,req)=time_req(time,req)+time;

                    maxcount=0;
                    for ii=1:1:10
                        %if analysis_avg_0b(time,ii,n)>maxcount
                        %    maxcount=analysis_avg_0b(time,ii,n);
                        %end
                        if analysis_avg_bn(time,ii,n)>maxcount
                            maxcount=analysis_avg_bn(time,ii,n);
                        end
                        %if analysis_max_0b(time,ii,n)>maxcount
                        %    maxcount=analysis_max_0b(time,ii,n);
                        %end
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        %if analysis_avg_0b(time,ii,n)==maxcount
                        if analysis_avg_bn(time,ii,n)==maxcount
                        %if analysis_max_0b(time,ii,n)==maxcount
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(1,n)
                            acc_req(time,req)=acc_req(time,req)+1/10000;
                        end
                        %if maxids(r(ii,1),1)~=test_0bias(1,n)
                        if maxids(r(ii,1),1)~=test_lenetbn(1,n)
                        %if maxids(r(ii,1),1)~=test_0bias_max(1,n)
                            err_req(time,req)=err_req(time,req)+1/10000;
                        end
                    end
                end
            end
        end
    end 
end
acc_req=acc_req/100;
time_req=time_req/10000;
%save lenet0b_req_poisson.mat acc_req time_req err_req
save lenetbn_req_2.mat acc_req time_req err_req
xlswrite('lenetbn_req_2.xlsx',acc_req,'acc');
xlswrite('lenetbn_req_2.xlsx',time_req,'time');
xlswrite('lenetbn_req_2.xlsx',err_req,'err');
%save lenet0bmax_req.mat acc_req time_req err_req

end