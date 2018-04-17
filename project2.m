clc,clear all
a=[];b=[];c=[];d=[];optimal=[];
for year=2010:2014
    [inputdata,outputdata,inputtest]=PreProcess(year);
    [~,~,~,~]=InputRestruct(inputdata,outputdata,year);
end
for year=2010:2014
    str=['res',num2str(year),'.mat'];
   [inputdata,outputdata,inputtest]=PreProcess(year);
   load(str);
   [~,pos]=min(errorres(:,1));
   [inputdataA,inputtestA]=GetBestInput(inputdata,inputtest,pos);
   [astar,~]=MethodA(inputdataA,outputdata,inputtestA);
   a=[a;astar];
   [~,pos]=min(errorres(:,2));
   [inputdataB,inputtestB]=GetBestInput(inputdata,inputtest,pos);
   [bstar,~]=MethodB(inputdataB,outputdata,inputtestB);
   b=[b;bstar];
   [~,pos]=min(errorres(:,3));
   [inputdataC,inputtestC]=GetBestInput(inputdata,inputtest,pos);
   [cstar,~]=MethodC(inputdataC,outputdata,inputtestC,powerres(pos));
   c=[c;cstar];
   [~,pos]=min(errorres(:,4));
   [inputdataD,inputtestD]=GetBestInput(inputdata,inputtest,pos);
   [dstar,~,~,~,~]=MethodD(inputdataD,outputdata,inputtestD,thetares(pos,1),thetares(pos,2),thetares(pos,3),0);
   d=[d;dstar];
   [pos,method]=find(errorres==min(min(errorres)));
   switch method
       case 1
           optimal=[optimal;astar];
       case 2
           optimal=[optimal;bstar];
       case 3
           optimal=[optimal;cstar];
       case 4
           optimal=[optimal;dstar];
   end
end
save GPR.mat a b c d optimal;