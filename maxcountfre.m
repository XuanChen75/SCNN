load analysis_avg_bn.mat analysis_avg_bn
load lenetbncnn.mat cnn
frequency12=zeros(300,301,301);
frequency1=zeros(300,301);
frequency2=zeros(300,301);
    for n=1:1:60000
        max1=0;max2=0;
        max1id=0;max2id=0;
        for ii=1:1:10
            if cnn(n,ii)>max1
                max2=max1;
                max2id=max1id;
                max1=cnn(n,ii);
                max1id=ii;
            else
                if cnn(n,ii)>max2
                    max2=cnn(n,ii);
                    max2id=ii;
                end
            end
        end
        for time=1:1:300
            spikecount1=analysis_avg_bn(time,n,max1id)+1;
            spikecount2=analysis_avg_bn(time,n,max2id)+1;
            frequency12(time,spikecount1,spikecount2)=frequency12(time,spikecount1,spikecount2)+1;
            frequency1(time,spikecount1)=frequency1(time,spikecount1)+1;
            frequency2(time,spikecount2)=frequency2(time,spikecount2)+1;
        end
    end
    save frequency.mat frequency12 frequency1 frequency2