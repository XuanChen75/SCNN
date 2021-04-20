function []=alexnet0b()
image=zeros(50000,3072);
load data_batch_1.mat data
image(1:1:10000,:)=data;
load data_batch_2.mat data
image(10001:1:20000,:)=data;
load data_batch_3.mat data
image(20001:1:30000,:)=data;
load data_batch_4.mat data
image(30001:1:40000,:)=data;
load data_batch_5.mat data
image(40001:1:50000,:)=data;
load 8795.mat pconv1 pconv2 pconv3 pconv4 pconv5 pfc1 pfc2 pfc3
pconv1 = permute(pconv1,[3 4 2 1]); %96 3 3 3
pconv2 = permute(pconv2,[3 4 2 1]); %256 96 3 3
pconv3 = permute(pconv3,[3 4 2 1]); %384 256 3 3
pconv4 = permute(pconv4,[3 4 2 1]); %384 384 3 3
pconv5 = permute(pconv5,[3 4 2 1]); %256 384 3 3
wconv2=zeros(3*3*96,256);
for kk=1:1:256
    wconv2(:,kk) = reshape(pconv2(:,:,:,kk),3*3*96,1)*0.25;
end
wconv3=zeros(3*3*256,384);
for kk=1:1:384
    wconv3(:,kk) = reshape(pconv3(:,:,:,kk),3*3*256,1)*0.25;
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
acc = 0;
%test_alexnet_0bias_max = zeros(10000,1);
image = single(image)/256;
count1=0;
count2=0;
count3=0;
count4=0;
count5=0;
count6=0;
count7=0;
count8=0;
fid1=fopen('value1.dat','w');
fid2=fopen('value2.dat','w');
fid3=fopen('value3.dat','w');
fid4=fopen('value4.dat','w');
fid5=fopen('value5.dat','w');
fid6=fopen('value6.dat','w');
fid7=fopen('value7.dat','w');
fid8=fopen('value8.dat','w');

real_value=zeros(50000,10);
for n=1:1:50000
    input_conv1=zeros(34,34,3);
    input_conv1(2:33,2:33,:) = permute(reshape(image(n,:),32,32,3),[2 1 3]);
    value_conv1=zeros(32,32,96);
    value_pooling1=zeros(18,18,96);
    input_conv2=zeros(16*16,3*3*96);
    value_conv2=zeros(16,16,256);
    value_conv2_temp=zeros(16*16,256);
    value_pooling2=zeros(10,10,256);
    input_conv3=zeros(8*8,3*3*256);
    value_conv3=zeros(8,8,384);
    value_conv3_temp=zeros(8*8,384);
    value_pooling3=zeros(10,10,384);
    input_conv4=zeros(8*8,3*3*384);
    value_conv4=zeros(8,8,384);
    value_conv4_temp=zeros(8*8,384);
    value_pooling4=zeros(10,10,384);
    input_conv5=zeros(8*8,3*3*384);
    value_conv5=zeros(8,8,256);
    value_conv5_temp=zeros(8*8,256);
    value_pooling5=zeros(4,4,256);
    input_fc1=zeros(4*4*256,1);
    value_fc1=zeros(1024,1);
    input_fc2=zeros(1024,1);
    value_fc2=zeros(1024,1);
    input_fc3=zeros(1024,1);
    value_fc3=zeros(10,1);

    for kk=1:1:96
        for ii=1:1:32
            for jj=1:1:32
                for xx=1:1:3
                    for yy=1:1:3
                        for zz=1:1:3
                            value_conv1(ii,jj,kk)=value_conv1(ii,jj,kk)+input_conv1(ii+xx-1,jj+yy-1,zz) * pconv1(xx,yy,zz,kk);
                        end
                    end
                end
            end
        end
    end
    
    value_conv1 = max(value_conv1,0);
    for kk=1:1:96
        for ii=1:1:32
            for jj=1:1:32
                if value_conv1(ii,jj,kk)>0
                    fprintf(fid1,'%f\n',value_conv1(ii,jj,kk));
                    count1=count1+1;
                end
            end
        end
    end
    for ii=1:1:16
        for jj=1:1:16
            value_pooling1(ii+1,jj+1,:) = value_conv1(ii*2-1,jj*2-1,:) + value_conv1(ii*2,jj*2-1,:) + value_conv1(ii*2-1,jj*2,:) + value_conv1(ii*2,jj*2,:);
            %value_pooling1(ii+1,jj+1,:) = max(value_conv1(ii*2-1,jj*2-1,:),value_conv1(ii*2,jj*2-1,:));
            %value_pooling1(ii+1,jj+1,:) = max(value_pooling1(ii+1,jj+1,:),value_conv1(ii*2-1,jj*2,:));
            %value_pooling1(ii+1,jj+1,:) = max(value_pooling1(ii+1,jj+1,:),value_conv1(ii*2,jj*2,:));
        end
    end

    count=0;
    for jj=1:1:16
        for ii=1:1:16
            count=count+1;
            input_conv2(count,:) = reshape(value_pooling1(ii:ii+2,jj:jj+2,:),1,3*3*96);
        end
    end

    value_conv2_temp = input_conv2 * wconv2;
    value_conv2_temp = max(value_conv2_temp,0);
    value_conv2 = reshape(value_conv2_temp,16,16,256);
    for kk=1:1:256
        for ii=1:1:16
            for jj=1:1:16
                if value_conv2(ii,jj,kk)>0
                    fprintf(fid2,'%f\n',value_conv2(ii,jj,kk));
                    count2=count2+1;
                end
            end
        end
    end
    for ii=1:1:8
        for jj=1:1:8
            value_pooling2(ii+1,jj+1,:) = (value_conv2(ii*2-1,jj*2-1,:) + value_conv2(ii*2,jj*2-1,:) + value_conv2(ii*2-1,jj*2,:) + value_conv2(ii*2,jj*2,:));
            %value_pooling2(ii+1,jj+1,:) = max(value_conv2(ii*2-1,jj*2-1,:),value_conv2(ii*2,jj*2-1,:));
            %value_pooling2(ii+1,jj+1,:) = max(value_pooling2(ii+1,jj+1,:),value_conv2(ii*2-1,jj*2,:));
            %value_pooling2(ii+1,jj+1,:) = max(value_pooling2(ii+1,jj+1,:),value_conv2(ii*2,jj*2,:));
        end
    end
    
    count=0;
    for jj=1:1:8
        for ii=1:1:8
            count=count+1;
            input_conv3(count,:) = reshape(value_pooling2(ii:ii+2,jj:jj+2,:),1,3*3*256);
        end
    end
    
    value_conv3_temp = input_conv3 * wconv3;
    value_conv3_temp = max(value_conv3_temp,0);
    value_conv3 = reshape(value_conv3_temp,8,8,384);
    for kk=1:1:384
        for ii=1:1:8
            for jj=1:1:8
                if value_conv3(ii,jj,kk)>0
                    fprintf(fid3,'%f\n',value_conv3(ii,jj,kk));
                    count3=count3+1;
                end
            end
        end
    end
    value_pooling3(2:9,2:9,:)=value_conv3;
    
    count=0;
    for jj=1:1:8
        for ii=1:1:8
            count=count+1;
            input_conv4(count,:) = reshape(value_pooling3(ii:ii+2,jj:jj+2,:),1,3*3*384);
        end
    end

    value_conv4_temp = input_conv4 * wconv4;
    value_conv4_temp = max(value_conv4_temp,0);
    value_conv4 = reshape(value_conv4_temp,8,8,384);
    for kk=1:1:384
        for ii=1:1:8
            for jj=1:1:8
                if value_conv4(ii,jj,kk)>0
                    fprintf(fid4,'%f\n',value_conv4(ii,jj,kk));
                    count4=count4+1;
                end
            end
        end
    end
    value_pooling4(2:9,2:9,:)=value_conv4;
    
    count=0;
    for jj=1:1:8
        for ii=1:1:8
            count=count+1;
            input_conv5(count,:) = reshape(value_pooling4(ii:ii+2,jj:jj+2,:),1,3*3*384);
            end
    end

    value_conv5_temp = input_conv5 * wconv5;
    value_conv5_temp = max(value_conv5_temp,0);
    value_conv5 = reshape(value_conv5_temp,8,8,256);
    for kk=1:1:256
        for ii=1:1:8
            for jj=1:1:8
                if value_conv5(ii,jj,kk)>0
                    fprintf(fid5,'%f\n',value_conv5(ii,jj,kk));
                    count5=count5+1;
                end
            end
        end
    end
    
    for ii=1:1:4
        for jj=1:1:4
            value_pooling5(ii,jj,:) = (value_conv5(ii*2-1,jj*2-1,:) + value_conv5(ii*2,jj*2-1,:) + value_conv5(ii*2-1,jj*2,:) + value_conv5(ii*2,jj*2,:));
            %value_pooling5(ii,jj,:) = max(value_conv5(ii*2-1,jj*2-1,:),value_conv5(ii*2,jj*2-1,:));
            %value_pooling5(ii,jj,:) = max(value_pooling5(ii,jj,:),value_conv5(ii*2-1,jj*2,:));
            %value_pooling5(ii,jj,:) = max(value_pooling5(ii,jj,:),value_conv5(ii*2,jj*2,:));
        end
    end
    
    input_fc1 = reshape(permute(value_pooling5,[2 1 3]),4*4*256,1);

    value_fc1 = pfc1 * input_fc1;
    input_fc2 = max(value_fc1,0);
    for kk=1:1:1024
        if value_fc1(kk,1)>0
            fprintf(fid6,'%f\n',value_fc1(kk,1));
            count6=count6+1;
        end
    end
    value_fc2 = pfc2 * input_fc2;
    input_fc3 = max(value_fc2,0);
    for kk=1:1:1024
        if value_fc2(kk,1)>0
            fprintf(fid7,'%f\n',value_fc2(kk,1));
            count7=count7+1;
        end
    end
    value_fc3 = pfc3 * input_fc3;
    for kk=1:1:10
        if value_fc3(kk,1)>0
            fprintf(fid8,'%f\n',value_fc3(kk,1));
            count8=count8+1;
        end
        real_value(n,kk)=value_fc3(kk,1);
    end
    fprintf('%d\n',n);

    %maxvalue=0; maxid=0;
    %for ii=1:1:10
    %    if value_fc3(ii,1)>maxvalue
    %        maxvalue = value_fc3(ii,1);
    %        maxid = ii-1;
    %    end
    %end
    %fprintf('n=%d label=%d  test=%d\n',n,labels(n,1),maxid);
    %test_alexnet_0bias_max(n,1)=maxid;
    %if labels(n,1) == maxid
    %    acc = acc + 1;
    %end
end
%fprintf('acc rate= %d / %d\n',acc,10000);
fprintf('count1=%d\n',count1);
fprintf('count2=%d\n',count2);
fprintf('count3=%d\n',count3);
fprintf('count4=%d\n',count4);
fprintf('count5=%d\n',count5);
fprintf('count6=%d\n',count6);
fprintf('count7=%d\n',count7);
fprintf('count8=%d\n',count8);
status=fclose(fid1);
status=fclose(fid2);
status=fclose(fid3);
status=fclose(fid4);
status=fclose(fid5);
status=fclose(fid6);
status=fclose(fid7);
status=fclose(fid8);
save alexnet_real_value.mat real_value
end