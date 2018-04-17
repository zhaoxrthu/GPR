function [outputtest,w,sigma_p]=MethodB(inputdata,outputdata,inputtest) 
    [n,~]=size(inputdata);
    [m,~]=size(inputtest);
    [output,~]=MethodA(inputdata,outputdata,inputdata);
    sigma_n2=sum((outputdata-output).^2)/(n-trace(inputdata'*inputdata/(inputdata'*inputdata)));
    %sigma_n2=var(outputdata-output);
    inputdata=[inputdata,ones(n,1)];
    inputtest=[inputtest,ones(m,1)];
    sigmap=cov(inputdata);
    A=1/sigma_n2*inputdata'*inputdata+pinv(sigmap);
    w=1/sigma_n2*(pinv(A)*inputdata'*outputdata);
    outputtest=inputtest*w;
    sigma_p=inv(A);
end