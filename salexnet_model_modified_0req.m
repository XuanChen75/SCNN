function []=salexnet_model_modified_0req()
load lumda_alexnet.mat lumda_conv1 lumda_conv2 lumda_conv3 lumda_conv4 lumda_conv5 lumda_fc1 lumda_fc2 lumda_fc3
vth1=lumda_conv1;
vth2=lumda_conv2/lumda_conv1;
vth3=lumda_conv3/lumda_conv2;
vth4=lumda_conv4/lumda_conv3;
vth5=lumda_conv5/lumda_conv4;
vth6=lumda_fc1/lumda_conv5;
vth7=lumda_fc2/lumda_fc1;
vth8=lumda_fc3/lumda_fc2;
load test_batch.mat data
load 8795.mat pconv1 pconv2 pconv3 pconv4 pconv5 pfc1 pfc2 pfc3
pconv1 = permute(pconv1,[3 4 2 1]); %96 3 3 3
pconv2 = permute(pconv2,[3 4 2 1]); %256 96 3 3
pconv3 = permute(pconv3,[3 4 2 1]); %384 256 3 3
pconv4 = permute(pconv4,[3 4 2 1]); %384 384 3 3
pconv5 = permute(pconv5,[3 4 2 1]); %256 384 3 3
for ii=1:1:3
    for jj=1:1:3
        for bb=1:1:8
            for cc=1:1:3
                for kk=1:1:96
                    pconv1_temp(ii,jj,bb,cc,kk)=pconv1(ii,jj,cc,kk)/(2^(bb));
                end
            end
        end
    end
end
wconv1 = zeros(3*3*3*8,96);
for kk=1:1:96
    wconv1(:,kk) = reshape(pconv1_temp(:,:,:,:,kk),3*3*3*8,1)*0.25;
end

wconv2=zeros(3*3*96,256);
for kk=1:1:256
    wconv2(:,kk) = reshape(pconv2(:,:,:,kk),3*3*96,1)*0.25;
end
wconv3=zeros(3*3*256,384);
for kk=1:1:384
    wconv3(:,kk) = reshape(pconv3(:,:,:,kk),3*3*256,1);
end
wconv4=zeros(3*3*384,384);
for kk=1:1:384
    wconv4(:,kk) = reshape(pconv4(:,:,:,kk),3*3*384,1);
end
wconv5=zeros(3*3*384,256);
for kk=1:1:256
    wconv5(:,kk) = reshape(pconv5(:,:,:,kk),3*3*384,1);
end
pfc1=pfc1*0.25;
data = single(data);
alexnet_time=zeros(1000,10000,10);
for n=1:1:10000
    
    neuron_conv1=zeros(32,32,96);
    neuron_conv2=zeros(16,16,256);
    neuron_conv3=zeros(8,8,384);
    neuron_conv4=zeros(8,8,384);
    neuron_conv5=zeros(8,8,256);
    pulse_conv1=zeros(32,32,96);
    pulse_conv2=zeros(16,16,256);
    pulse_conv3=zeros(8,8,384);
    pulse_conv4=zeros(8,8,384);
    pulse_conv5=zeros(8,8,256);
    
    input_conv1=zeros(32*32,3*3*3*8);
    neuron_pooling1=zeros(18,18,96);
    
    input_conv2=zeros(16*16,3*3*96);
    neuron_pooling2=zeros(10,10,256);
    
    input_conv3=zeros(8*8,3*3*256);
    neuron_pooling3=zeros(10,10,384);
    
    input_conv4=zeros(8*8,3*3*384);
    neuron_pooling4=zeros(10,10,384);
    
    input_conv5=zeros(8*8,3*3*384);
    neuron_pooling5=zeros(4,4,256);
    
    input_fc1=zeros(4*4*256,1);
    neuron_fc1=zeros(1024,1);
    pulse_fc1=zeros(1024,1);
    input_fc2=zeros(1024,1);
    neuron_fc2=zeros(1024,1);
    pulse_fc2=zeros(1024,1);
    input_fc3=zeros(1024,1);
    neuron_fc3=zeros(10,1);
    pulse_fc3=zeros(10,1);
    countpulse = zeros(10);
    
    input=zeros(34,34,8,3);
    data_temp=permute(reshape(data(n,:),32,32,3),[2 1 3]);
    for ii=2:1:33
        for jj=2:1:33
            for kk=1:1:3
                original=data_temp(ii-1,jj-1,kk);
                for bb=8:-1:1
                    input(ii,jj,bb,kk)=mod(original,2);
                    original=floor(original/2);
                end
            end
        end
    end
    
        count=0;
        for jj=1:1:32
            for ii=1:1:32
                count=count+1;
                input_conv1(count,:) = reshape(input(ii:ii+2,jj:jj+2,:,:),1,3*3*3*8);
            end
        end

    for time=1:1:1000
        
        neuron_conv1 = neuron_conv1 + reshape(input_conv1 * wconv1,32,32,96);
    
        for ii=1:1:16
            for jj=1:1:16
                neuron_pooling1(ii+1,jj+1,:) = pulse_conv1(ii*2-1,jj*2-1,:) + pulse_conv1(ii*2,jj*2-1,:) + pulse_conv1(ii*2-1,jj*2,:) + pulse_conv1(ii*2,jj*2,:);
            end
        end

        count=0;
        for jj=1:1:16
            for ii=1:1:16
                count=count+1;
                input_conv2(count,:) = reshape(neuron_pooling1(ii:ii+2,jj:jj+2,:),1,3*3*96);
            end
        end

        neuron_conv2 = neuron_conv2 + reshape(input_conv2 * wconv2,16,16,256);
        for ii=1:1:8
            for jj=1:1:8
                neuron_pooling2(ii+1,jj+1,:) = pulse_conv2(ii*2-1,jj*2-1,:)+pulse_conv2(ii*2,jj*2-1,:)+pulse_conv2(ii*2-1,jj*2,:)+pulse_conv2(ii*2,jj*2,:);
            end
        end
    
        count=0;
        for jj=1:1:8
            for ii=1:1:8
                count=count+1;
                input_conv3(count,:) = reshape(neuron_pooling2(ii:ii+2,jj:jj+2,:),1,3*3*256);
            end
        end
    
        neuron_conv3 = neuron_conv3 + reshape(input_conv3 * wconv3,8,8,384);
        neuron_pooling3(2:9,2:9,:) = pulse_conv3;
    
        count=0;
        for jj=1:1:8
            for ii=1:1:8
                count=count+1;
                input_conv4(count,:) = reshape(neuron_pooling3(ii:ii+2,jj:jj+2,:),1,3*3*384);
            end
        end

        neuron_conv4 = neuron_conv4 + reshape(input_conv4 * wconv4,8,8,384);
        neuron_pooling4(2:9,2:9,:) = pulse_conv4;
    
        count=0;
        for jj=1:1:8
            for ii=1:1:8
                count=count+1;
                input_conv5(count,:) = reshape(neuron_pooling4(ii:ii+2,jj:jj+2,:),1,3*3*384);
            end
        end

        neuron_conv5 = neuron_conv5 + reshape(input_conv5 * wconv5,8,8,256);
    
        for ii=1:1:4
            for jj=1:1:4
                neuron_pooling5(ii,jj,:) = pulse_conv5(ii*2-1,jj*2-1,:)+pulse_conv5(ii*2,jj*2-1,:)+pulse_conv5(ii*2-1,jj*2,:)+pulse_conv5(ii*2,jj*2,:);
            end
        end
    
        input_fc1 = reshape(permute(neuron_pooling5,[2 1 3]),4*4*256,1);
        neuron_fc1 = neuron_fc1 + pfc1 * input_fc1;
        input_fc2 = pulse_fc1;
        neuron_fc2 = neuron_fc2 + pfc2 * input_fc2;
        input_fc3 = pulse_fc2;
        neuron_fc3 = neuron_fc3 + pfc3 * input_fc3;
       
        for ii=1:1:32
            for jj=1:1:32
                for kk=1:1:96
                    if neuron_conv1(ii,jj,kk) >= vth1
                        pulse_conv1(ii,jj,kk)=1;
                        neuron_conv1(ii,jj,kk)=neuron_conv1(ii,jj,kk)-vth1;
                    else
                        %if neuron_conv1(ii,jj,kk)<0
                        %    neuron_conv1(ii,jj,kk)=0;
                        %end
                        pulse_conv1(ii,jj,kk)=0;
                    end
                end
            end
        end

        for ii=1:1:16
            for jj=1:1:16
                for kk=1:1:256
                    if neuron_conv2(ii,jj,kk)>=vth2
                        pulse_conv2(ii,jj,kk)=1;
                        neuron_conv2(ii,jj,kk)=neuron_conv2(ii,jj,kk)-vth2;
                    else
                        %if neuron_conv2(ii,jj,kk)<0
                        %    neuron_conv2(ii,jj,kk)=0;
                        %end
                        pulse_conv2(ii,jj,kk)=0;
                    end
                end
            end
        end
        
        for ii=1:1:8
            for jj=1:1:8
                for kk=1:1:384
                    if neuron_conv3(ii,jj,kk)>=vth3
                        pulse_conv3(ii,jj,kk)=1;
                        neuron_conv3(ii,jj,kk)=neuron_conv3(ii,jj,kk)-vth3;
                    else
                        %if neuron_conv3(ii,jj,kk)<0
                        %    neuron_conv3(ii,jj,kk)=0;
                        %end
                        pulse_conv3(ii,jj,kk)=0;
                    end
                end
            end
        end
        
        for ii=1:1:8
            for jj=1:1:8
                for kk=1:1:384
                    if neuron_conv4(ii,jj,kk)>=vth4
                        pulse_conv4(ii,jj,kk)=1;
                        neuron_conv4(ii,jj,kk)=neuron_conv4(ii,jj,kk)-vth4;
                    else
                        %if neuron_conv4(ii,jj,kk)<0
                        %    neuron_conv4(ii,jj,kk)=0;
                        %end
                        pulse_conv4(ii,jj,kk)=0;
                    end
                end
            end
        end
        
        for ii=1:1:8
            for jj=1:1:8
                for kk=1:1:256
                    if neuron_conv5(ii,jj,kk)>=vth5
                        pulse_conv5(ii,jj,kk)=1;
                        neuron_conv5(ii,jj,kk)=neuron_conv5(ii,jj,kk)-vth5;
                    else
                        %if neuron_conv5(ii,jj,kk)<0
                        %    neuron_conv5(ii,jj,kk)=0;
                        %end
                        pulse_conv5(ii,jj,kk)=0;
                    end
                end
            end
        end
        
        for ii=1:1:1024
            if neuron_fc1(ii,1)>=vth6
                neuron_fc1(ii,1)=neuron_fc1(ii,1)-vth6;
                pulse_fc1(ii,1)=1;
            else
                %if neuron_fc1(ii,1)<0
                %    neuron_fc1(ii,1)=0;
                %end
                pulse_fc1(ii,1)=0;
            end
        end
        
        for ii=1:1:1024
            if neuron_fc2(ii,1)>=vth7
                neuron_fc2(ii,1)=neuron_fc2(ii,1)-vth7;
                pulse_fc2(ii,1)=1;
            else
                %if neuron_fc2(ii,1)<0
                %    neuron_fc2(ii,1)=0;
                %end
                pulse_fc2(ii,1)=0;
            end
        end
        
        for ii=1:1:10
            if neuron_fc3(ii,1)>=vth8
                neuron_fc3(ii,1)=neuron_fc3(ii,1)-vth8;
                pulse_fc3(ii,1)=1;
            else
                %if neuron_fc3(ii,1)<0
                %    neuron_fc3(ii,1)=0;
                %end
                pulse_fc3(ii,1)=0;
            end
        end
        
        for ii=1:1:10
            if pulse_fc3(ii)==1
                countpulse(ii)=countpulse(ii)+1;
            end
			alexnet_time(time,n,ii)=countpulse(ii);
        end
        fprintf('%d %d\n',n,time);
    end
end
save alexnet_time.mat alexnet_time
end