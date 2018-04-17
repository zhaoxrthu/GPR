function [errorres,powerres,thetares,method]=InputRestruct(inputdata,outputdata,year)
    errorres=zeros(255,4);
    powerres=zeros(255,1);
    thetares=zeros(255,3);
    method=zeros(255,1);
    for i=1:255
        bin=zeros(1,8);
        temp=i;
        for j=1:8
           bin(9-j)=mod(temp,2);
           temp=floor(temp/2);
        end
        input=inputdata.*bin;
        for j=1:8
           if bin(9-j)==0
               input(:,9-j)=[];
           end
        end
        num=ceil(0.8*length(outputdata));
        x2=outputdata(num+1:end,:);
        errormet=zeros(1,4);
        [star,~]=MethodA(input(1:num,:),outputdata(1:num,:),input(num+1:end,:));
        errormet(1)=(x2-star)'*(x2-star)/length(x2);
        [star,~]=MethodB(input(1:num,:),outputdata(1:num,:),input(num+1:end,:));
        errormet(2)=(x2-star)'*(x2-star)/length(x2);
        errortemp=zeros(1,10);
        for j=1:10
            [star,~]=MethodC(input(1:num,:),outputdata(1:num,:),input(num+1:end,:),j);
            errortemp(j)=(x2-star)'*(x2-star)/length(x2);
        end
        [errormet(3),powerres(i)]=min(errortemp);
        [star,~,sigma_n,sigma,l]=MethodD(input(1:num,:),outputdata(1:num,:),input(num+1:end,:),12,5,150,1);
        errormet(4)=(x2-star)'*(x2-star)/length(x2);
        thetares(i,:)=[sigma_n,sigma,l];
        [~,method(i)]=min(errormet);
        errorres(i,:)=errormet;
        i
    end
    switch year
        case 2010
            save res2010.mat errorres powerres thetares method;
        case 2011
            save res2011.mat errorres powerres thetares method;
        case 2012
            save res2012.mat errorres powerres thetares method;
        case 2013
            save res2013.mat errorres powerres thetares method;
        case 2014
            save res2014.mat errorres powerres thetares method;
    end
    year
end