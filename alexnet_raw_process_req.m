function []=alexnet_raw_process_req()
load alexnet_time.mat alexnet_time
load test_batch.mat labels
acc_req=zeros(1000,20);
time_req=zeros(1000,20);

    
for n=1:1:10000
    deltacount=zeros(1000,1);
    for time=1:1:1000
        max1=0;max2=0;
        for ii=1:1:10
            if alexnet_time(time,n,ii)>max1
                max2=0;
                max1=alexnet_time(time,n,ii);
            else
                if alexnet_time(time,n,ii)>max2
                    max2=alexnet_time(time,n,ii);
                end
            end
        end
        deltacount(time,1)=max1-max2;
    end
    for req=1:1:20
        flag=0;acttime=0;accr=0;
        for time=1:1:1000
            if flag==1
                acc_req(time,req)=acc_req(time,req)+accr;
                time_req(time,req)=time_req(time,req)+acttime;
            else
                if deltacount(time,1)>=(req+21)
                    flag=1;
                    acttime=time;
                    max1=0;maxid=0;
                    for ii=1:1:10
                        if alexnet_time(time,n,ii)>max1
                            max1=alexnet_time(time,n,ii);
                            maxid=ii-1;
                        end
                    end
                    if maxid==labels(n,1)
                        accr=1;
                    else
                        accr=0;
                    end
                    acc_req(time,req)=acc_req(time,req)+accr;
                    time_req(time,req)=time_req(time,req)+acttime;
                    
                else
                    time_req(time,req)=time_req(time,req)+time;
                    
                    maxcount=0;
                    for ii=1:1:10
                        if alexnet_time(time,n,ii)>maxcount
                            maxcount=alexnet_time(time,n,ii);
                        end
                        
                    end
                    maxids=zeros(10,1);
                    maxidno=0;
                    for ii=1:1:10
                        if alexnet_time(time,n,ii)==maxcount
                        
                            maxidno=maxidno+1;
                            maxids(maxidno,1)=ii-1;
                        end
                    end
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(n,1)
                            
                            
                            acc_req(time,req)=acc_req(time,req)+1/10000;
                            
                        end
                        
                    end
                end
            end
        end
    end 
end
time_req=time_req/10000;
acc_req=acc_req/100;
save alexnet_req_2.mat acc_req time_req 
xlswrite('alexnet_req_2.xlsx',acc_req,'acc');
xlswrite('alexnet_req_2.xlsx',time_req,'time');

end