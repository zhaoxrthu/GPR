function [inputdata,inputtest]=GetBestInput(inputdata,inputtest,i)
    temp=i;
    for j=1:8
       if mod(temp,2)==0
           inputdata(:,9-j)=[];
           inputtest(:,9-j)=[];
       end
       temp=floor(temp/2);
    end
end