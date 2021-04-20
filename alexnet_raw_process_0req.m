function []=alexnet_raw_process_0req()
load alexnet_time.mat alexnet_time
load test_batch.mat labels
acc=zeros(1000,1);

    
for n=1:1:10000
        for time=1:1:1000
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
                    if maxidno==1
                         if maxids(1,1)==labels(n,1)
                            acc(time,1)=acc(time,1)+1;
                        end
                    else
                    r=randi(maxidno,10000,1);
                    for ii=1:1:10000
                        if maxids(r(ii,1),1)==labels(n,1)
                            
                            
                            acc(time,1)=acc(time,1)+1/10000;
                            
                        end
                        
                    end
                    end
                end
end
acc=acc/100;
save alexnet_0req.mat acc 
xlswrite('alexnet_0req.xlsx',acc,'acc');

end