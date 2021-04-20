function []=lenet0b()

load train.mat traindata

data=zeros(32,32,60000);
    for ii=3:1:30
        for jj=3:1:30
            data(ii,jj,:)=traindata(ii-2,jj-2,:);
        end
    end

%load scnn_0bias.mat wconv1 wconv2 wfc1 wfc2 wfc3
load scnn_0bias_max.mat wconv1 wconv2 wfc1 wfc2 wfc3
wconv1 = permute(wconv1,[3 4 2 1]); %6 1 5 5
wconv2 = permute(wconv2,[3 4 2 1]); %16 6 5 5

count = 0;

max1=0;count1=0;activation_conv1=[];
max2=0;count2=0;activation_conv2=[];
max3=0;count3=0;activation_fc1=[];
max4=0;count4=0;activation_fc2=[];
max5=0;count5=0;activation_fc3=[];

for n=1:1:60000
    
    value_conv1 = zeros(28,28,6);
    value_conv2 = zeros(10,10,16);
    value_fc1 = zeros(120,1);
    value_fc2 = zeros(84,1);
    value_fc3 = zeros(10,1);
    
    value_pooling1 = zeros(14,14,6);
    value_pooling2 = zeros(400);
    value_pooling2_temp = zeros(5,5,16);

    for kk=1:1:6
        for ii=1:1:28
            for jj=1:1:28
                for xx=1:1:5
                    for yy=1:1:5
                        value_conv1(ii,jj,kk)=value_conv1(ii,jj,kk)+data(ii+xx-1,jj+yy-1,n)/256 * wconv1(xx,yy,1,kk);
                    end
                end
                if value_conv1(ii,jj,kk)>0
                    count1=count1+1;
                    activation_conv1(count1)=value_conv1(ii,jj,kk);
                end
                if value_conv1(ii,jj,kk)>max1
                    max1 = value_conv1(ii,jj,kk);
                end
            end
        end
    end
    
    value_conv1 = max(value_conv1,0);
    for channel=1:1:6
        for ii=1:1:14
            for jj=1:1:14
                %value_pooling1(ii,jj,channel) = 0.25*(value_conv1(ii*2-1,jj*2-1,channel)+value_conv1(ii*2,jj*2-1,channel)+value_conv1(ii*2-1,jj*2,channel)+value_conv1(ii*2,jj*2,channel));
                value_pooling1(ii,jj,channel) = max(value_conv1(ii*2-1,jj*2-1,channel),value_conv1(ii*2,jj*2-1,channel));
                value_pooling1(ii,jj,channel) = max(value_conv1(ii*2-1,jj*2,channel),value_pooling1(ii,jj,channel));
                value_pooling1(ii,jj,channel) = max(value_conv1(ii*2,jj*2,channel),value_pooling1(ii,jj,channel));
            end
        end
    end
    
    for kk=1:1:16
        for ii=1:1:10
            for jj=1:1:10
                for channel=1:1:6
                    for xx=1:1:5
                        for yy=1:1:5
                            value_conv2(ii,jj,kk)=value_conv2(ii,jj,kk)+value_pooling1(ii+xx-1,jj+yy-1,channel) * wconv2(xx,yy,channel,kk);
                        end
                    end
                end
                if value_conv2(ii,jj,kk)>0
                    count2=count2+1;
                    activation_conv2(count2)=value_conv2(ii,jj,kk);
                end
                if value_conv2(ii,jj,kk)>max2
                    max2 = value_conv2(ii,jj,kk);
                end
            end
        end
    end
    
    value_conv2 = max(value_conv2,0);
    for channel=1:1:16
        for ii=1:1:5
            for jj=1:1:5
                %value_pooling2_temp(ii,jj,channel) = 0.25*(value_conv2(ii*2-1,jj*2-1,channel)+value_conv2(ii*2,jj*2-1,channel)+value_conv2(ii*2-1,jj*2,channel)+value_conv2(ii*2,jj*2,channel));
                value_pooling2_temp(ii,jj,channel) = max(value_conv2(ii*2-1,jj*2-1,channel),value_conv2(ii*2,jj*2-1,channel));
                value_pooling2_temp(ii,jj,channel) = max(value_conv2(ii*2-1,jj*2,channel),value_pooling2_temp(ii,jj,channel));
                value_pooling2_temp(ii,jj,channel) = max(value_conv2(ii*2,jj*2,channel),value_pooling2_temp(ii,jj,channel));
            end
        end
    end
    value_pooling2 = reshape(permute(value_pooling2_temp,[2 1 3]),400,1);
    
    for ii=1:1:120
        value_fc1(ii)=value_fc1(ii)+wfc1(ii,:) * value_pooling2;
        if value_fc1(ii)>0
            count3=count3+1;
            activation_fc1(count3)=value_fc1(ii);
        end
        if value_fc1(ii)>max3
            max3 = value_fc1(ii);
        end
    end
    value_fc1 = max(value_fc1,0);
    for ii=1:1:84
        value_fc2(ii)=value_fc2(ii)+wfc2(ii,:) * value_fc1;
        if value_fc2(ii)>0
            count4=count4+1;
            activation_fc2(count4)=value_fc2(ii);
        end
        if value_fc2(ii)>max4
            max4 = value_fc2(ii);
        end
    end
    value_fc2 = max(value_fc2,0);
    for ii=1:1:10
        value_fc3(ii)=value_fc3(ii)+wfc3(ii,:) * value_fc2;
        if value_fc3(ii)>0
            count5=count5+1;
            activation_fc3(count5)=value_fc3(ii);
        end
        if value_fc3(ii)>max5
            max5 = value_fc3(ii);
        end
    end
    %maxvalue=0; maxid=0;
    %for ii=1:1:10
    %    if value_fc3(ii)>maxvalue
    %        maxvalue = value_fc3(ii);
    %        maxid = ii-1;
    %    end
        %fprintf('n=%d i=%d:%d value=%f\n',n,ii-1,count(ii),value_fc3(ii));
    %end
    %fprintf('n=%d label=%d  test=%d\n',n,labels(1,n),maxid);
    %test_0bias_max(1,n)=maxid;
    %if labels(1,n) == maxid
    %    count = count + 1;
    %end
end
%fprintf('acc rate= %d / %d\n',count,10000);
fprintf('%f %f %f %f %f\n',max1,max2,max3,max4,max5);
fprintf('%d %d %d %d %d\n',count1,count2,count3,count4,count5);
%save test_0bias_max.mat test_0bias_max
%save data.mat data
%save labels.mat labels
%save activation_conv1.mat activation_conv1
%save activation_conv2.mat activation_conv2
%save activation_fc1.mat activation_fc1
%save activation_fc2.mat activation_fc2
%save activation_fc3.mat activation_fc3
sort_conv1=sort(activation_conv1,'descend');
sort_conv2=sort(activation_conv2,'descend');
sort_fc1=sort(activation_fc1,'descend');
sort_fc2=sort(activation_fc2,'descend');
sort_fc3=sort(activation_fc3,'descend');
lumda_conv1=sort_conv1(round(count1/1000));
lumda_conv2=sort_conv2(round(count2/1000));
lumda_fc1=sort_fc1(round(count3/1000));
lumda_fc2=sort_fc2(round(count4/1000));
lumda_fc3=sort_fc3(round(count5/1000));
fprintf('%f %f %f %f %f\n',lumda_conv1,lumda_conv2,lumda_fc1,lumda_fc2,lumda_fc3);
save lumda_lenet0bmax.mat lumda_conv1 lumda_conv2 lumda_fc1 lumda_fc2 lumda_fc3
%wconv1=wconv1/lumda_conv1;
%wconv2=wconv2/lumda_conv2*lumda_conv1;
%wfc1=wfc1/lumda_fc1*lumda_conv2;
%wfc2=wfc2/lumda_fc2*lumda_fc1;
%wfc3=wfc3/lumda_fc3*lumda_fc2;
%save scnn_0bias_norm.mat wconv1 wconv2 wfc1 wfc2 wfc3
end