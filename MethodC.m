function [outputtest,w]=MethodC(inputdata,outputdata,inputtest,k)
    [n,m]=size(inputdata);
    polyinputdata=zeros(n,k*m);
    [n,m]=size(inputtest);
    polyinputtest=zeros(n,k*m);
    for i=1:m
        for j=1:k
            polyinputdata(:,k*(i-1)+j)=inputdata(:,i).^(k-j+1);
            polyinputtest(:,k*(i-1)+j)=inputtest(:,i).^(k-j+1);
        end
    end
    [outputtest,w]=MethodA(polyinputdata,outputdata,polyinputtest);
%     w=pinv(polyinputdata'*polyinputdata)*polyinputdata'*outputdata;
%     outputtest=polyinputtest*w;
end