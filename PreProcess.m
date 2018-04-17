function [inputdata,outputdata,inputtest]=PreProcess(year)
    str=['data',num2str(year)];
    load([str,'.mat']);
    eval(['data=',str,';']);
    inputdata=[];outputdata=[];inputtest=[];
    for i=1:length(data.TargetScore1)
        if data.TargetScore1(i)==-1
            inputtest=[inputtest;data.Score(i,:)];
        elseif ~isnan(data.TargetScore1(i))
            inputdata=[inputdata;data.Score(i,:)];
            outputdata=[outputdata;data.TargetScore1(i)];
        end
    end
end