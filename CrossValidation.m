clc,clear all,close all
astar=[];bstar=[];cstar=[];dstar=[];rjstar=[];x2=[];
yastar=[];ybstar=[];ycstar=[];ydstar=[];yreal=[];
count=zeros(1,5);
errora=zeros(1,6);errorb=zeros(1,6);
errorc=zeros(1,6);errord=zeros(1,6);
errorrj=zeros(1,6);
for year=2010:2014
    [input,output,~]=PreProcess(year);
    num=ceil(0.8*length(output));
    inputdata=input(1:num,:);
    outputdata=output(1:num,:);
    [astar,~]=MethodA(inputdata,outputdata,input(num+1:end,:));yastar=[yastar;astar];
    [bstar,~,~]=MethodB(inputdata,outputdata,input(num+1:end,:));ybstar=[ybstar;bstar];
    [cstar,w]=MethodC(inputdata,outputdata,input(num+1:end,:),9);ycstar=[ycstar;cstar];
    [dstar,C,sigma_n,sigma,l]=MethodD(inputdata,outputdata,input(num+1:end,:),12,5,150);
    ydstar=[ydstar;dstar];
    x2=output(num+1:end,:);
    yreal=[yreal;x2];
    templen=length(x2);
    count(year-2009)=templen;
    errora(year-2009)=(x2-astar)'*(x2-astar)/templen;
    errorb(year-2009)=(x2-bstar)'*(x2-bstar)/templen;
    errorc(year-2009)=(x2-cstar)'*(x2-cstar)/templen;
    errord(year-2009)=(x2-dstar)'*(x2-dstar)/templen;
    errora(6)=errora(6)+errora(year-2009)*templen;
    errorb(6)=errorb(6)+errorb(year-2009)*templen;
    errorc(6)=errorc(6)+errorc(year-2009)*templen;
    errord(6)=errord(6)+errord(year-2009)*templen;
end

% %plot:forecast and reality
% for i=1:4
%    switch i
%        case 1
%            ystar=yastar;
%            error=errora;
%            str='��׼���Իع�ģ�͵ģ��Ǹ��ʣ���С�������';
%        case 2
%            ystar=ybstar;
%            error=errorb;
%            str='��׼���Իع�ģ�͵ĸ������';
%        case 3
%            ystar=ycstar;
%            error=errorc;
%            str={'����ʽ�������Ĺ������Իع�ģ��';'(��������n=9)'};
%        case 4
%            ystar=ydstar;
%            error=errord;
%            str={'GPR����';['(\sigma_n^2=',num2str(sigma_n^2),'   \sigma_f^2=',num2str(sigma^2),'   l=',num2str(l),')']};
%    end
%    figure;
%    start=1;
%    for j=1:5
%       subplot(3,2,j);
%       x=1:count(j);
%       hold on;
%       plot(x,ystar(start:start+count(j)-1),'r*',x,yreal(start:start+count(j)-1),'ko');
%       stem(x,max(ystar(start:start+count(j)-1),yreal(start:start+count(j)-1)),'Marker','none');
%       axis([0,count(j)+1,min([ystar(start:start+count(j)-1);yreal(start:start+count(j)-1)])-5,max([ystar(start:start+count(j)-1);yreal(start:start+count(j)-1)])+5]);
% %        xlabel(['MSE:',num2str(error(j))]);ylabel('�ɼ�');
%       title([num2str(j+2009),'��(MSE:',num2str(error(j)),')']);
%       start=start+count(j);
%    end
%    gca=legend('Ԥ��ֵ','��ʵֵ');
%    set(gca,'Position',[0.83 0.91 0.06 0.05]);
%    suptitle(str);
% end
% 
% %plot:3sigma of project2
% for t=1:1
%     figure;
%     x=1:8;
%     for i=1:5
%         [input,output,~]=PreProcess(i+2009);
%         num=ceil(0.8*length(output));
%         inputdata=input(1:num,:);
%         outputdata=output(1:num,:);
%         [~,w,sigma_p]=MethodB(inputdata,outputdata,input(num+1:end,:));
%         w=w(1:8);
%         sigma=sqrt(diag(sigma_p));
%         sigma=sigma(1:8);
%         subplot(3,2,i);
%         plot(x,w(1:8),'r*');
%         hold on;
%         for j=1:8
%             x2=j.*ones(100,1);
%             y=linspace(w(j)-3*sigma(j),w(j)+3*sigma(j),100);
%             plot(x2,y,'k');
%             plot(j,w(j)-3*sigma(j),'k+',j,w(j)+3*sigma(j),'k+');
%             axis([0,9,min(w-3*sigma-0.1),max(w+3*sigma+0.1)]);
%         end
%         title([num2str(i+2009),'��'],'FontSize',8);
%         xlabel('w','FontSize',8);
%     end
%     gca=legend('w�ľ�ֵ','3\sigma����');
%     set(gca,'Position',[0.83 0.91 0.06 0.05]);
%     suptitle('ϵ��w�ķֲ����');
% end
% 
% %plot:project3
% for t=1:1
%    error=zeros(10,6);
%    for i=1:10
%        for year=2010:2014
%             [input,output,~]=PreProcess(year);
%             num=ceil(0.8*length(output));
%             inputdata=input(1:num,:);
%             outputdata=output(1:num,:);
%             [cstar,w]=MethodC(inputdata,outputdata,input(num+1:end,:),i);
%             x2=output(num+1:end,:);
%             templen=length(x2);
%             error(i,year-2009)=(x2-cstar)'*(x2-cstar)/templen;
%             error(i,6)=error(i,6)+error(i,year-2009)*templen;
%        end
%    end
%    error(:,6)=error(:,6)./sum(count);
%    figure;
%    hold on;
%    for i=1:5
%        plot(1:10,error(:,i));
%    end
%    %legend('2010��MSE','2011��MSE','2012��MSE','2013��MSE','2014��MSE');
%    plot(1:10,error(:,6),'k','LineWidth',3.5);
%    legend('2010��MSE','2011��MSE','2012��MSE','2013��MSE','2014��MSE','��ƽ��MSE');
%    xlabel('��������n');ylabel('MSE');
%    title('MSE����������n�仯���');
% end

%plot:GPR para ada
% for t=1:1
%     figure;
%     for year=2010:2014
%         subplot(3,2,year-2009);
%         [input,output,~]=PreProcess(year);
%         num=ceil(0.8*length(output));
%         inputdata=input(1:num,:);
%         outputdata=output(1:num,:);
%         [dstar,C,sigma_n,sigma,l]=MethodD(inputdata,outputdata,input(num+1:end,:),12,5,150);
%         x2=output(num+1:end,:);
%         templen=length(x2);
%         count(year-2009)=templen;
%         error=(x2-dstar)'*(x2-dstar)/templen;
%     %     figure;
%         x=1:templen;
%         hold on;
%         plot(x,dstar,'r*',x,x2,'ko');
%         stem(x,max(dstar,x2),'Marker','none');
%         axis([0,templen+1,min([dstar;x2])-5,max([dstar;x2])+5]);
%         %gca=legend('Ԥ��ֵ','��ʵֵ');
%         title({[num2str(year),'��(MSE:',num2str(error),')(\sigma_n^2=',num2str(sigma_n^2),'   \sigma_f^2=',num2str(sigma^2),'   l=',num2str(l),')']});
%     end
%     gca=legend('Ԥ��ֵ','��ʵֵ');
%     set(gca,'Position',[0.83 0.91 0.06 0.05]);
%     suptitle('GPR����(�ݶ��½�����������)');
% end

len=sum(count);
errora(6)=errora(6)/len;
errorb(6)=errorb(6)/len;
errorc(6)=errorc(6)/len;
errord(6)=errord(6)/len;
% errorrj(6)=errorrj(6)/len;
errora
errorb
errorc
errord