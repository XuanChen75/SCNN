function []=slenet_model_modified_analysis_bias()
load lumda_lenetbn.mat lumda_conv1 lumda_conv2 lumda_fc1 lumda_fc2 lumda_fc3
vth1=lumda_conv1;
vth2=lumda_conv2/lumda_conv1;
vth3=lumda_fc1/lumda_conv2;
vth4=lumda_fc2/lumda_fc1;
vth5=lumda_fc3/lumda_fc2;
load train.mat traindata
data=zeros(32,32,60000);
data(3:1:30,3:1:30,:)=traindata;
load scnn_lenetbn.mat wconv1 wconv2 wfc1 wfc2 wfc3
load scnn_lenetbn.mat bconv1 bconv2 bfc1 bfc2 bfc3
wconv1 = permute(wconv1,[3 4 2 1]); %6 1 5 5
wconv2 = permute(wconv2,[3 4 2 1]); %16 6 5 5
count=0;
for jj=1:1:5
    for ii=1:1:5
        for bb=1:1:8
                count=count+1;
                for kk=1:1:6
                    wconv1_temp(count,kk)=wconv1(ii,jj,1,kk)/(2^bb);
                end
        end
    end
end
count=0;
for cc=1:1:6
for jj=1:1:5
    for ii=1:1:5
        for bb=1:1:4
                count=count+1;
                for kk=1:1:16
                    wconv2_temp(count,kk)=wconv2(ii,jj,cc,kk)*0.25;
                end
        end
    end
end
end
count=0;
for cc=1:1:400
    for bb=1:1:4
        count=count+1;
        for kk=1:1:120
            wfc1_temp(count,kk)=wfc1(kk,cc)*0.25;
        end
    end
end
wfc2_temp = wfc2';
wfc3_temp = wfc3';
wconv1_temp=wconv1_temp/vth1;
wconv2_temp=wconv2_temp/vth2;
wfc1_temp=wfc1_temp/vth3;
wfc2_temp=wfc2_temp/vth4;
wfc3_temp=wfc3_temp/vth5;
bconv1=bconv1/(vth1);
bconv2=bconv2/(vth1*vth2);
bfc1=bfc1/(vth1*vth2*vth3);
bfc2=bfc2/(vth1*vth2*vth3*vth4);
bfc3=bfc3/(vth1*vth2*vth3*vth4*vth5);
neuron_conv1_bias = zeros(28*28,6);
for ii=1:1:28*28
    for jj=1:1:6
        neuron_conv1_bias(ii,jj)=bconv1(1,jj);
		conv1_bias(ii,jj)=bconv1(1,jj)*vth1;
    end
end
neuron_conv2_bias = zeros(10*10,16);
for ii=1:1:10*10
    for jj=1:1:16
        neuron_conv2_bias(ii,jj)=bconv2(1,jj);
		conv2_bias(ii,jj)=bconv2(1,jj)*vth1*vth2;
    end
end
fc1_bias=bfc1*vth1*vth2*vth3;
fc2_bias=bfc2*vth1*vth2*vth3*vth4;
fc3_bias=bfc3*vth1*vth2*vth3*vth4*vth5;

analysis_avg_bn=zeros(300,60000,10);
cnn=zeros(60000,10);

for n=1:1:60000
    
    neuron_conv1 = zeros(28*28,6);
    cnn1 = zeros(28*28,6);
    pulse_conv1 = zeros(28*28,6);
    neuron_conv2 = zeros(10*10,16);
    cnn2 = zeros(10*10,16);
    pulse_conv2 = zeros(10*10,16);
    neuron_fc1 = zeros(1,120);
    cnn3 = zeros(1,120);
    pulse_fc1 = zeros(1,120);
    neuron_fc2 = zeros(1,84);
    cnn4 = zeros(1,84);
    pulse_fc2 = zeros(1,84);
    neuron_fc3 = zeros(1,10);
    cnn5 = zeros(1,10);
    pulse_fc3 = zeros(1,10);
    count_spike = zeros(10);
    
    input1=zeros(28*28,200);
    counti=0;
    for jj=1:1:28
        for ii=1:1:28
                counti=counti+1;
                countj=0;
                for yy=1:1:5
                    for xx=1:1:5     
                        original=data(ii+xx-1,jj+yy-1,n);
                        binary=zeros(8);
                        for bb=1:1:8
                            binary(bb)=mod(original,2);
                            original=floor(original/2);
                        end
                        for bb=1:1:8
                            input1(counti,countj+bb)=binary(9-bb);
                        end
                        countj=countj+8;
                    end
                end
        end
    end
    
    cnn1=max(input1*wconv1_temp+conv1_bias,0);
    counti=0;
        for jj=1:1:10
            for ii=1:1:10
                counti=counti+1;
                countj=0;
                for cc=1:1:6
                    for yy=1:1:5
                        for xx=1:1:5
                            for bb=-1:1:0
                                for aa=-1:1:0
                                    countj=countj+1;
                                    row=2*(ii+xx-1)+aa;
                                    col=2*(jj+yy-1)+bb;
                                    input2(counti,countj)=cnn1((col-1)*28+row,cc);
                                end
                            end
                        end
                    end
                end
            end
        end
        cnn2=max(input2*wconv2_temp+conv2_bias,0);
        countj=0;
                for cc=1:1:16
                    for xx=1:1:5
                        for yy=1:1:5
                            for bb=-1:1:0
                                for aa=-1:1:0
                                    countj=countj+1;
                                    row=2*(xx)+aa;
                                    col=2*(yy)+bb;
                                    input3(1,countj)=cnn2((col-1)*10+row,cc);
                                end
                            end
                        end
                    end
                end

        cnn3=max(input3*wfc1_temp+fc1_bias,0);
        cnn4=max(cnn3*wfc2_temp+fc2_bias,0);
        cnn5=max(cnn4*wfc3_temp+fc3_bias,0);
    
    for time=1:1:300
        neuron_conv1=neuron_conv1+input1*wconv1_temp+neuron_conv1_bias;
        counti=0;
        for jj=1:1:10
            for ii=1:1:10
                counti=counti+1;
                countj=0;
                for cc=1:1:6
                    for yy=1:1:5
                        for xx=1:1:5
                            for bb=-1:1:0
                                for aa=-1:1:0
                                    countj=countj+1;
                                    row=2*(ii+xx-1)+aa;
                                    col=2*(jj+yy-1)+bb;
                                    input2(counti,countj)=pulse_conv1((col-1)*28+row,cc);
                                end
                            end
                        end
                    end
                end
            end
        end
        neuron_conv2=neuron_conv2+input2*wconv2_temp+neuron_conv2_bias;

                countj=0;
                for cc=1:1:16
                    for xx=1:1:5
                        for yy=1:1:5
                            for bb=-1:1:0
                                for aa=-1:1:0
                                    countj=countj+1;
                                    row=2*(xx)+aa;
                                    col=2*(yy)+bb;
                                    input3(1,countj)=pulse_conv2((col-1)*10+row,cc);
                                end
                            end
                        end
                    end
                end

        neuron_fc1=neuron_fc1+input3*wfc1_temp+bfc1;
        input4=pulse_fc1;
        neuron_fc2=neuron_fc2+input4*wfc2_temp+bfc2;
        input5=pulse_fc2;
        neuron_fc3=neuron_fc3+input5*wfc3_temp+bfc3;
        
        for cc=1:1:28*28
                for kk=1:1:6
                    if neuron_conv1(cc,kk)>=1
                        pulse_conv1(cc,kk)=1;
                        neuron_conv1(cc,kk)=neuron_conv1(cc,kk)-1;
                    else
                        pulse_conv1(cc,kk)=0;
                    end
                end
        end
        
        for cc=1:1:100
                for kk=1:1:16
                    if neuron_conv2(cc,kk)>=1
                        pulse_conv2(cc,kk)=1;
                        neuron_conv2(cc,kk)=neuron_conv2(cc,kk)-1;
                    else
                        pulse_conv2(cc,kk)=0;
                    end
                end
        end
        
        for ii=1:1:120
            if neuron_fc1(1,ii)>=1
                neuron_fc1(1,ii)=neuron_fc1(1,ii)-1;
                pulse_fc1(1,ii)=1;
            else
                pulse_fc1(1,ii)=0;
            end
        end
        for ii=1:1:84
            if neuron_fc2(1,ii)>=1
                neuron_fc2(1,ii)=neuron_fc2(1,ii)-1;
                pulse_fc2(1,ii)=1;
            else
                pulse_fc2(1,ii)=0;
            end
        end
        for ii=1:1:10
            if neuron_fc3(1,ii)>=1
                neuron_fc3(1,ii)=neuron_fc3(1,ii)-1;
                pulse_fc3(1,ii)=1;
            else
               pulse_fc3(1,ii)=0;
            end
        end
        for ii=1:1:10
            if pulse_fc3(1,ii)==1
                count_spike(ii)=count_spike(ii)+1;
            end
        end
		for ii=1:1:10
			analysis_avg_bn(time,n,ii)=count_spike(ii);
			cnn(n,ii)=cnn5(1,ii);
		end
		fprintf('%d %d\n',n,time);
    end
    
end
save analysis_avg_bn.mat analysis_avg_bn cnn
end