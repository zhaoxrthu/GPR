clear all,close all, clc
figure;
for i=1:5
   str=['res',num2str(i+2009),'.mat'];
   [inputdata,outputdata,inputtest]=PreProcess(i+2009);
   load(str);
   [~,pos]=min(errorres(:,1)); 
   [inputdata,inputtest]=GetBestInput(inputdata,inputtest,pos);
   num=ceil(0.8*length(outputdata));
   input=inputdata(1:num,:);
   output=outputdata(1:num,:);
   [astar,~]=MethodA(input,output,inputdata(num+1:end,:));
   x2=outputdata(num+1:end,:);
   error=(x2-astar)'*(x2-astar)/length(x2);
   x=1:length(x2); 
   subplot(3,2,i);
   hold on;
   plot(x,astar,'r*',x,x2,'ko'); 
   stem(x,max(astar,x2),'Marker','none');
   axis([0,length(x2)+1,min([astar;x2])-5,max([astar;x2])+5]);
   title({[num2str(i+2009),'��(MSE:',num2str(error),')(�Ա����ռ��ţ�',num2str(pos),')']});
end
gca=legend('Ԥ��ֵ','��ʵֵ');
set(gca,'Position',[0.83 0.91 0.06 0.05]);
suptitle('��׼���Իع�ģ�ͣ��ع��Ա����ռ䣩');

figure;
for i=1:5
   str=['res',num2str(i+2009),'.mat'];
   [inputdata,outputdata,inputtest]=PreProcess(i+2009);
   load(str);
   [~,pos]=min(errorres(:,2)); 
   [inputdata,inputtest]=GetBestInput(inputdata,inputtest,pos);
   num=ceil(0.8*length(outputdata));
   input=inputdata(1:num,:);
   output=outputdata(1:num,:);
   [bstar,~]=MethodB(input,output,inputdata(num+1:end,:));
   x2=outputdata(num+1:end,:);
   error=(x2-bstar)'*(x2-bstar)/length(x2);
   x=1:length(x2); 
   subplot(3,2,i);
   hold on;
   plot(x,bstar,'r*',x,x2,'ko'); 
   stem(x,max(bstar,x2),'Marker','none');
   axis([0,length(x2)+1,min([bstar;x2])-5,max([bstar;x2])+5]);
   title({[num2str(i+2009),'��(MSE:',num2str(error),')(�Ա����ռ��ţ�',num2str(pos),')']});
end
gca=legend('Ԥ��ֵ','��ʵֵ');
set(gca,'Position',[0.83 0.91 0.06 0.05]);
suptitle('��׼���Իع�ģ�͵ĸ�����⣨�ع��Ա����ռ䣩');

figure;
for i=1:5
   str=['res',num2str(i+2009),'.mat'];
   [inputdata,outputdata,inputtest]=PreProcess(i+2009);
   load(str);
   [~,pos]=min(errorres(:,3)); 
   [inputdata,inputtest]=GetBestInput(inputdata,inputtest,pos);
   num=ceil(0.8*length(outputdata));
   input=inputdata(1:num,:);
   output=outputdata(1:num,:);
   [cstar,~]=MethodC(input,output,inputdata(num+1:end,:),powerres(pos));
   x2=outputdata(num+1:end,:);
   error=(x2-cstar)'*(x2-cstar)/length(x2);
   x=1:length(x2); 
   subplot(3,2,i);
   hold on;
   plot(x,cstar,'r*',x,x2,'ko'); 
   stem(x,max(cstar,x2),'Marker','none');
   axis([0,length(x2)+1,min([cstar;x2])-5,max([cstar;x2])+5]);
   title({[num2str(i+2009),'��(MSE:',num2str(error),')'];['(�Ա����ռ��ţ�',num2str(pos),',����������',num2str(powerres(pos)),')']},'FontSize',9);
end
gca=legend('Ԥ��ֵ','��ʵֵ');
set(gca,'Position',[0.83 0.91 0.06 0.05]);
suptitle('����ʽ�������Ĺ������Իع�ģ�ͣ��ع��Ա����ռ䣩');

figure;
for i=1:5
   str=['res',num2str(i+2009),'.mat'];
   [inputdata,outputdata,inputtest]=PreProcess(i+2009);
   load(str);
   [~,pos]=min(errorres(:,4)); 
   [inputdata,inputtest]=GetBestInput(inputdata,inputtest,pos);
   num=ceil(0.8*length(outputdata));
   input=inputdata(1:num,:);
   output=outputdata(1:num,:);
   [dstar,~]=MethodD(input,output,inputdata(num+1:end,:),thetares(pos,1),thetares(pos,2),thetares(pos,3),0);
   x2=outputdata(num+1:end,:);
   error=(x2-dstar)'*(x2-dstar)/length(x2);
   x=1:length(x2); 
   subplot(3,2,i);
   hold on;
   plot(x,dstar,'r*',x,x2,'ko'); 
   stem(x,max(dstar,x2),'Marker','none');
   axis([0,length(x2)+1,min([dstar;x2])-5,max([dstar;x2])+5]);
   title({[num2str(i+2009),'��(MSE:',num2str(error),')'];...
       ['(�Ա����ռ��ţ�',num2str(pos),')  (\sigma_n^2=',num2str(thetares(pos,1)^2),'   \sigma_f^2=',num2str((thetares(pos,2))^2),'   l=',num2str(thetares(pos,3)),')']},'FontSize',9);
end
gca=legend('Ԥ��ֵ','��ʵֵ');
set(gca,'Position',[0.83 0.91 0.06 0.05]);
suptitle('��˹���̻ع鷽�����ع��Ա����ռ䣩');

60*109.68+50*(164.44+199.78+163.27)+54*124.01
