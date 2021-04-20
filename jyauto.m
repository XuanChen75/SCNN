load analysis_avg_0b_poisson.mat analysis_avg_0b cnn;
%load analysis_avg_bn.mat analysis_avg_bn;
%load analysis_max_0b.mat analysis_max_0b cnn;
%load lenetbncnn.mat cnn

	flag=0;

for time=1:1:300
	for n=1:1:60000
        for ii=1:1:10
            if (analysis_avg_0b(time,n,ii)>0)&&(flag==0)
            %if (analysis_avg_bn(time,n,ii)>0)&&(flag==0)
            %if (analysis_max_0b(time,n,ii)>0)&&(flag==0)
                flag=1;initime=time;
            end
        end
    end
end
fitresult=zeros(300,302-initime,2);

for time=initime:1:300
    
    count=zeros(time+1,1);
    order=zeros(time+1,1);
	for n=1:1:60000
    for ii=1:1:10
        if (cnn(n,ii)>0)
         count(analysis_avg_0b(time,n,ii)+1,1)=count(analysis_avg_0b(time,n,ii)+1,1)+1;
         %count(analysis_avg_bn(time,n,ii)+1,1)=count(analysis_avg_bn(time,n,ii)+1,1)+1;
         %count(analysis_max_0b(time,n,ii)+1,1)=count(analysis_max_0b(time,n,ii)+1,1)+1;
        end
    end
	end
    maxt=0;
    for ii=1:1:(time+1)
        if count(ii,1)>maxt
            maxt=count(ii,1);
        end
    end
    sample=zeros(time+1,maxt);
    for n=1:1:60000
    for ii=1:1:10
        if (cnn(n,ii)>0)
        order(analysis_avg_0b(time,n,ii)+1,1)=order(analysis_avg_0b(time,n,ii)+1,1)+1;
        sample(analysis_avg_0b(time,n,ii)+1,order(analysis_avg_0b(time,n,ii)+1))=cnn(n,ii);
        %order(analysis_avg_bn(time,n,ii)+1,1)=order(analysis_avg_bn(time,n,ii)+1,1)+1;
        %sample(analysis_avg_bn(time,n,ii)+1,order(analysis_avg_bn(time,n,ii)+1))=cnn(n,ii);
        %order(analysis_max_0b(time,n,ii)+1,1)=order(analysis_max_0b(time,n,ii)+1,1)+1;
        %sample(analysis_max_0b(time,n,ii)+1,order(analysis_max_0b(time,n,ii)+1))=cnn(n,ii);
        end
    end
	end
    for jj=1:1:(time+2-initime)
        sample_sub=zeros(1,order(jj,1));
        for ii=1:1:order(jj,1)
            sample_sub(1,ii)=sample(jj,ii);
        end
        if (jj==1)
            pd = fitdist(sample_sub','HalfNormal');
            fitresult(time,jj,1)=0;
            fitresult(time,jj,2)=pd.sigma;
        else
            [fitresult(time,jj,1),fitresult(time,jj,2)] = normfit(sample_sub);
        end
    end
end
save fitresult_avg0b_poisson.mat fitresult
%save fitresult_avgbn.mat fitresult
%save fitresult_max0b.mat fitresult