function [outputtest,C,sigma_n,sigma,l]=MethodD(inputdata,outputdata,inputtest,sigma_n,sigma,l,ada)
    [m1,~]=size(inputdata);
    [m2,~]=size(inputtest);
    inputdata=[inputdata,ones(m1,1)];
    inputtest=[inputtest,ones(m2,1)];
    if ada==1
        theta=GradientDescent(inputdata,outputdata,[sigma_n,sigma,l]);    
        sigma_n=theta(1);sigma=theta(2);l=theta(3);
    end
%     theta
    Cov=GenerateK(inputdata,inputtest,sigma,l);
    C21=Cov(m1+1:end,1:m1);
    C=Cov(1:m1,1:m1);
    outputtest=C21/(C+sigma_n^2.*eye(m1))*outputdata;
end

function K=GenerateK(inputdata,inputtest,sigma,l)
    input=[inputdata;inputtest];
    [m,~]=size(input);
    Cov=zeros(m,m);
    for i=1:m
        diff=ones(m,1)*input(i,:)-input(:,:);
        Cov(i,:)=sigma^2*exp(-sum(diff,2)'.^2/(2*l^2));
    end
    K=Cov;
end

function thetare=GradientDescent(inputdata,outputdata,thetain)
    thetanext=thetain;
    iter=100;
    for i=1:iter
        theta=thetanext;
        grad=GradLogMarginLikehood(inputdata,outputdata,theta);
        grad=grad./sqrt(grad*grad');
        alpha=1;
        while LogMarginLikehood(inputdata,outputdata,thetanext)>=LogMarginLikehood(inputdata,outputdata,theta)
            if alpha<=0.0001
                break;
            end
            alpha=alpha/2;
            thetanext=theta-alpha*grad;
        end
        opti=abs(LogMarginLikehood(inputdata,outputdata,thetanext)-LogMarginLikehood(inputdata,outputdata,theta));
        if(opti<0.00001*abs(LogMarginLikehood(inputdata,outputdata,thetanext)))
            break;
        end
    end
    thetare=thetanext;
end

function logp=LogMarginLikehood(inputdata,outputdata,theta)
    K=GenerateK(inputdata,[],theta(2),theta(3))+theta(1)^2.*eye(length(outputdata));
    logp=1/2*outputdata'/K*outputdata+1/2*log(det(K))+length(outputdata)/2*log(2*pi);
end

function gradlogp=GradLogMarginLikehood(inputdata,outputdata,theta)
    K=GenerateK(inputdata,[],theta(2),theta(3))+theta(1)^2.*eye(length(outputdata));
    alpha=K\outputdata;
    gradlogp=zeros(1,3);
    gradlogp(1)=-1/2*trace((alpha*alpha'-inv(K))*2*theta(1)*eye(length(outputdata)));
    gradlogp(2)=-1/2*trace((alpha*alpha'-inv(K))*(K-theta(1)^2.*eye(length(outputdata)))*2/theta(2));
    tempgrad=zeros(length(outputdata),length(outputdata));
    for i=1:length(outputdata)
        for j=1:length(outputdata)
            x1=inputdata(i,:);x2=inputdata(j,:);
            tempgrad(i,j)=((x1-x2)*(x1-x2)')/(theta(3)^3);
        end
    end
    gradlogp(3)=-1/2*trace((alpha*alpha'-inv(K))*(K-theta(1)^2.*eye(length(outputdata)))*tempgrad);
end