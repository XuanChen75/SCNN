function []=slenet_raw_process()
load raw_avg_0b_poisson.mat analysis_avg_0b
%load raw_avg_bn.mat analysis_avg_bn
%load raw_max_0b.mat analysis_max_0b
load labels.mat labels
acc_lenet0b_0req=zeros(300,1);
%acc_lenetbn_0req=zeros(300,1);
%acc_lenet0bmax_0req=zeros(300,1);
err_lenet0b_0req=zeros(300,1);
%err_lenetbn_0req=zeros(300,1);
%err_lenet0bmax_0req=zeros(300,1);
td_lenet0b_0req=zeros(300,1);
%td_lenetbn_0req=zeros(300,1);
%td_lenet0bmax_0req=zeros(300,1);

for time=1:1:300
    
    for n=1:1:10000
        maxcount=0;
        for ii=1:1:10
            if analysis_avg_0b(time,ii,n)>maxcount
                maxcount=analysis_avg_0b(time,ii,n);
            end
            %if analysis_avg_bn(time,ii,n)>maxcount
            %    maxcount=analysis_avg_bn(time,ii,n);
            %end
            %if analysis_max_0b(time,ii,n)>maxcount
            %    maxcount=analysis_max_0b(time,ii,n);
            %end
        end
        maxid=zeros(10,1);
        maxidno=0;
        for ii=1:1:10
            if analysis_avg_0b(time,ii,n)==maxcount
            %if analysis_avg_bn(time,ii,n)==maxcount
            %if analysis_max_0b(time,ii,n)==maxcount
                maxidno=maxidno+1;
                maxid(maxidno,1)=ii-1;
            end
        end
        r=randi(maxidno,10000,1);
        if maxidno>1
            td_lenet0b_0req(time,1)=td_lenet0b_0req(time,1)+1;
            %td_lenetbn_0req(time,1)=td_lenetbn_0req(time,1)+1;
            %td_lenet0bmax_0req(time,1)=td_lenet0bmax_0req(time,1)+1;
        end
        for ii=1:1:10000
            if maxid(r(ii,1),1)==labels(1,n)
                acc_lenet0b_0req(time,1)=acc_lenet0b_0req(time,1)+1/10000;
                %acc_lenetbn_0req(time,1)=acc_lenetbn_0req(time,1)+1/10000;
                %acc_lenet0bmax_0req(time,1)=acc_lenet0bmax_0req(time,1)+1/10000;
            else
                if maxidno>1
                    err_lenet0b_0req(time,1)=err_lenet0b_0req(time,1)+1/10000;
                    %err_lenetbn_0req(time,1)=err_lenetbn_0req(time,1)+1/10000;
                    %err_lenet0bmax_0req(time,1)=err_lenet0bmax_0req(time,1)+1/10000;
                end
            end
        end
    end
end
acc_lenet0b_0req=acc_lenet0b_0req/100;
%acc_lenetbn_0req=acc_lenetbn_0req/100;
%acc_lenet0bmax_0req=acc_lenet0bmax_0req/100;

%save lenet0b_0req.mat acc_lenet0b_0req err_lenet0b_0req td_lenet0b_0req
save lenet0b_poisson_0req.mat acc_lenet0b_0req err_lenet0b_0req td_lenet0b_0req
%save lenetbn_0req.mat acc_lenetbn_0req err_lenetbn_0req td_lenetbn_0req
%save lenet0bmax_0req.mat acc_lenet0bmax_0req err_lenet0bmax_0req td_lenet0bmax_0req
%xlswrite('lenet0b_0req.xlsx',acc_lenet0b_0req,'acc');
%xlswrite('lenet0b_0req.xlsx',err_lenet0b_0req,'err');
%xlswrite('lenet0b_0req.xlsx',td_lenet0b_0req,'td');
xlswrite('lenet0b_poisson_0req.xlsx',acc_lenet0b_0req,'acc');
xlswrite('lenet0b_poisson_0req.xlsx',err_lenet0b_0req,'err');
xlswrite('lenet0b_poisson_0req.xlsx',td_lenet0b_0req,'td');
%xlswrite('lenetbn_0req.xlsx',acc_lenetbn_0req,'acc');
%xlswrite('lenetbn_0req.xlsx',err_lenetbn_0req,'err');
%xlswrite('lenetbn_0req.xlsx',td_lenetbn_0req,'td');
%xlswrite('lenet0bmax_0req.xlsx',acc_lenet0bmax_0req,'acc');
%xlswrite('lenet0bmax_0req.xlsx',err_lenet0bmax_0req,'err');
%xlswrite('lenet0bmax_0req.xlsx',td_lenet0bmax_0req,'td');
end