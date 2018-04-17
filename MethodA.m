function [outputtest,w]=MethodA(inputdata,outputdata,inputtest)
    inputdata=[inputdata,ones(length(outputdata),1)];
    w=pinv(inputdata'*inputdata)*inputdata'*outputdata;
    [h,~]=size(inputtest);
    outputtest=[inputtest,ones(h,1)]*w;
end