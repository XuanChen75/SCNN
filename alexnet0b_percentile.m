function []=alexnet0b_percentile()
count1=1776951258;count1_1000=1776951;
count2=664435669;count2_1000=664435;
count3=198002939;count3_1000=198002;
count4=162515761;count4_1000=162515;
count5=122651415;count5_1000=122651;
count6=16878872;count6_1000=16878;
count7=30209331;count7_1000=30209;
count8=204952;count8_1000=204;
fid1=fopen('value1.dat','r');
sort_conv1=zeros(count1_1000*2,1);

for ii=1:1:count1_1000
    str=fgetl(fid1);
    value=str2double(str);
    sort_conv1(ii,1)=value;
end
for ii=1:1:999
    for jj=1:1:count1_1000
        str=fgetl(fid1);
        value=str2double(str);
        sort_conv1(jj+count1_1000,1)=value;
    end
    sort_conv1=sort(sort_conv1,'descend');
    fprintf('%d %d\n',1,ii);
end
for jj=1:1:count1-count1_1000*1000
    str=fgetl(fid1);
    value=str2double(str);
    sort_conv1(jj+count1_1000,1)=value;
end

sort_conv1=sort(sort_conv1,'descend');
    fprintf('%d %d\n',1,1000);

status=fclose(fid1);
fid2=fopen('value2.dat','r');
sort_conv2=zeros(count2_1000*2,1);

for ii=1:1:count2_1000
    str=fgetl(fid2);
    value=str2double(str);
    sort_conv2(ii,1)=value;
end
for ii=1:1:999
    for jj=1:1:count2_1000
        str=fgetl(fid2);
        value=str2double(str);
        sort_conv2(jj+count2_1000,1)=value;
    end
    sort_conv2=sort(sort_conv2,'descend');
        fprintf('%d %d\n',2,ii);

end
for jj=1:1:count2-count2_1000*1000
    str=fgetl(fid2);
    value=str2double(str);
    sort_conv2(jj+count2_1000,1)=value;
end
sort_conv2=sort(sort_conv2,'descend');
    fprintf('%d %d\n',2,1000);

status=fclose(fid2);
fid3=fopen('value3.dat','r');
sort_conv3=zeros(count3_1000*2,1);

for ii=1:1:count3_1000
    str=fgetl(fid3);
    value=str2double(str);
    sort_conv3(ii,1)=value;
end
for ii=1:1:999
    for jj=1:1:count3_1000
        str=fgetl(fid3);
        value=str2double(str);
        sort_conv3(jj+count3_1000,1)=value;
    end
    sort_conv3=sort(sort_conv3,'descend');
            fprintf('%d %d\n',3,ii);

end
for jj=1:1:count3-count3_1000*1000
    str=fgetl(fid3);
    value=str2double(str);
    sort_conv3(jj+count3_1000,1)=value;
end
sort_conv3=sort(sort_conv3,'descend');
    fprintf('%d %d\n',3,1000);

status=fclose(fid3);
fid4=fopen('value4.dat','r');
sort_conv4=zeros(count4_1000*2,1);

for ii=1:1:count4_1000
    str=fgetl(fid4);
    value=str2double(str);
    sort_conv4(ii,1)=value;
end
for ii=1:1:999
    for jj=1:1:count4_1000
        str=fgetl(fid4);
        value=str2double(str);
        sort_conv4(jj+count4_1000,1)=value;
    end
    sort_conv4=sort(sort_conv4,'descend');
            fprintf('%d %d\n',4,ii);

end
for jj=1:1:count4-count4_1000*1000
    str=fgetl(fid4);
    value=str2double(str);
    sort_conv4(jj+count4_1000,1)=value;
end
sort_conv4=sort(sort_conv4,'descend');
    fprintf('%d %d\n',4,1000);

status=fclose(fid4);
fid5=fopen('value5.dat','r');
sort_conv5=zeros(count5_1000*2,1);

for ii=1:1:count5_1000
    str=fgetl(fid5);
    value=str2double(str);
    sort_conv5(ii,1)=value;
end
for ii=1:1:999
    for jj=1:1:count5_1000
        str=fgetl(fid5);
        value=str2double(str);
        sort_conv5(jj+count5_1000,1)=value;
    end
    sort_conv5=sort(sort_conv5,'descend');
            fprintf('%d %d\n',5,ii);

end
for jj=1:1:count5-count5_1000*1000
    str=fgetl(fid5);
    value=str2double(str);
    sort_conv5(jj+count5_1000,1)=value;
end
sort_conv5=sort(sort_conv5,'descend');
    fprintf('%d %d\n',5,1000);

status=fclose(fid5);
fid6=fopen('value6.dat','r');
sort_fc1=zeros(count6_1000*2,1);

for ii=1:1:count6_1000
    str=fgetl(fid6);
    value=str2double(str);
    sort_fc1(ii,1)=value;
end
for ii=1:1:999
    for jj=1:1:count6_1000
        str=fgetl(fid6);
        value=str2double(str);
        sort_fc1(jj+count6_1000,1)=value;
    end
    sort_fc1=sort(sort_fc1,'descend');
            fprintf('%d %d\n',6,ii);

end
for jj=1:1:count6-count6_1000*1000
    str=fgetl(fid6);
    value=str2double(str);
    sort_fc1(jj+count6_1000,1)=value;
end
sort_fc1=sort(sort_fc1,'descend');
    fprintf('%d %d\n',6,1000);

status=fclose(fid6);
fid7=fopen('value7.dat','r');
sort_fc2=zeros(count7_1000*2,1);

for ii=1:1:count7_1000
    str=fgetl(fid7);
    value=str2double(str);
    sort_fc2(ii,1)=value;
end
for ii=1:1:999
    for jj=1:1:count7_1000
        str=fgetl(fid7);
        value=str2double(str);
        sort_fc2(jj+count7_1000,1)=value;
    end
    sort_fc2=sort(sort_fc2,'descend');
            fprintf('%d %d\n',7,ii);

end
for jj=1:1:count7-count7_1000*1000
    str=fgetl(fid7);
    value=str2double(str);
    sort_fc2(jj+count7_1000,1)=value;
end
sort_fc2=sort(sort_fc2,'descend');
    fprintf('%d %d\n',7,1000);

status=fclose(fid7);
fid8=fopen('value8.dat','r');
sort_fc3=zeros(count8_1000*2,1);
for ii=1:1:count8_1000
    str=fgetl(fid8);
    value=str2double(str);
    sort_fc3(ii,1)=value;
end
for ii=1:1:999
    for jj=1:1:count8_1000
        str=fgetl(fid8);
        value=str2double(str);
        sort_fc3(jj+count8_1000,1)=value;
    end
    sort_fc3=sort(sort_fc3,'descend');
            fprintf('%d %d\n',8,ii);

end
for jj=1:1:count8-count8_1000*1000
    str=fgetl(fid8);
    value=str2double(str);
    sort_fc3(jj+count8_1000,1)=value;
end
sort_fc3=sort(sort_fc3,'descend');
    fprintf('%d %d\n',8,1000);

status=fclose(fid8);
lumda_conv1=sort_conv1(count1_1000,1);
lumda_conv2=sort_conv2(count2_1000,1);
lumda_conv3=sort_conv3(count3_1000,1);
lumda_conv4=sort_conv4(count4_1000,1);
lumda_conv5=sort_conv5(count5_1000,1);
lumda_fc1=sort_fc1(count6_1000,1);
lumda_fc2=sort_fc2(count7_1000,1);
lumda_fc3=sort_fc3(count8_1000,1);
fprintf('%f %f %f %f %f %f %f %f\n',lumda_conv1,lumda_conv2,lumda_conv3,lumda_conv4,lumda_conv5,lumda_fc1,lumda_fc2,lumda_fc3);
save lumda_alexnet.mat lumda_conv1 lumda_conv2 lumda_conv3 lumda_conv4 lumda_conv5 lumda_fc1 lumda_fc2 lumda_fc3

end