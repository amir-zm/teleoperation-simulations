clc;
close;
a=size(xl1.Data(:));
z=1000;
writerObj = VideoWriter('3th.avi');
writerObj.Quality=100;
%writerObj.FrameRate = 90;
open(writerObj);
figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'color','white');
for j = 1:z:a
        aa1=subplot(2,2,[1,3]);
        bb1=get(aa1,'Position');
        bb1(4)=bb1(4)-0.06;%%ertefa
        bb1(3)=bb1(3)+0.09;%%arz
        bb1(2)=bb1(2)+0.05;%%bala payin
        bb1(1)=bb1(1)-0.07;%%chap rast
        set(aa1,'Position',bb1);  
        %%%
%         th = 0:pi/50:2*pi;
%         xunit = 0.1 * cos(th) + 0.05;
%         yunit =  0.1 * sin(th) + 0.35;
%         xunit1 = 0.2 * cos(th) + 0.05;
%         yunit1 =  0.2 * sin(th) + 0.35;
        %%%
        al=[0 xl1.Data(j) xl2.Data(j)];
        bl=[0 yl1.Data(j) yl2.Data(j)];
        %%%
        ar=[0 xr1.Data(j) xr2.Data(j) xr3.Data(j)];
        br=[0 yr1.Data(j) yr2.Data(j) yr3.Data(j)];
        %^^^^^^^^^^^^
        kk1=plot(al,bl,'b','LineWidth',2.5);
        set(gca,'FontSize',16);
        hold on;
        %^^
        kk3=plot(ar,br,'r','LineWidth',2.5);
        set(gca,'FontSize',16);
        hold on;
%         plot(xunit, yunit,'r');
%         hold on;
%         h = plot(xunit1, yunit1,'b');
%         hold on;
        xlim([-1 1]);
        ylim([0 1.1]);
        ll=legend([kk1 kk3],{'Local','Remote'},'Location','NorthWest');
        set(ll,'Interpreter','latex','fontsize',18);
        %%%
        ss=[0.04 0.04];
        yy=[0 3];
        plot(ss,yy);
        hold on;
        string=['\bf Time(Sec.)=' num2str(xl1.Time(j))];
        ss=text(1.1,2.67,string);
        set(ss,'Interpreter','latex','fontsize',15);
        %%%
        if fh_x.Time(j)<15
        string='$\rightarrow$';
        zp=text(xl2.Data(:,j)-0.3,yl2.Data(:,j)-0.005,string);
        set(zp,'Interpreter','latex','fontsize',30,'color','k');
        %%%
        string=['$f_{h_{x}}$=' num2str(fh_x.Data(j))];
        zp2=text(xl2.Data(:,j)-0.3,yl2.Data(:,j)+0.07,string);
        set(zp2,'Interpreter','latex','fontsize',18,'color','k');
        %%%
        string='$\uparrow$';
        zp=text(xl2.Data(:,j)-0.08,yl2.Data(:,j)-0.08,string);
        set(zp,'Interpreter','latex','fontsize',30,'color','k');
        %%%
        string=['$f_{h_{y}}$=' num2str(fh_y.Data(j))];
        zp2=text(xl2.Data(:,j)+0.02,yl2.Data(:,j)-0.1,string);
        set(zp2,'Interpreter','latex','fontsize',18,'color','k');
        %%%
        elseif fh_x.Time(j)>15 && fh_x.Time(j)<18
        string='$\uparrow$';
        zp=text(xl2.Data(:,j)-0.08,yl2.Data(:,j)-0.08,string);
        set(zp,'Interpreter','latex','fontsize',30,'color','k');
        %%%
        string=['$f_{h_{y}}$=' num2str(fh_y.Data(j))];
        zp2=text(xl2.Data(:,j)+0.02,yl2.Data(:,j)-0.1,string);
        set(zp2,'Interpreter','latex','fontsize',18,'color','k');
        else
        end
        %%%
        xlabel('X-direction','interpreter','latex','fontsize',17);
        ylabel('Y-direction','interpreter','latex','fontsize',17);
        %%%%
        aa4=subplot(2,2,2);
        bb4=get(aa4,'Position');
        %bb4(4)=bb4(4)+0.055;%%ertefa
        bb4(3)=bb4(3)+0.09;%%arz
        %bb4(2)=bb4(2)-0.01;%%bala payin
        bb4(1)=bb4(1)-0.015;%%chap rast
        set(aa4,'Position',bb4); 
        %%%^^^
        plot(xl2.Time(1:j),xl2.Data(:,1:j),'b',...
             xr3.Time(1:j),xr3.Data(:,1:j),'r','LineWidth',1.5);
        set(gca,'FontSize',16);
        xx1=legend('Local','Remote');
        set(xx1,'Interpreter','latex','fontsize',18);
        zz=ylabel('End-Effector in X-direction');
        set(zz,'Interpreter','latex','fontsize',14);
        xlim([0 100]);
        ylim([-2 3]);
        xlabel('Time(Sec.)','interpreter','latex','fontsize',17);
        %%%^^^
        aa7=subplot(2,2,4);
        bb7=get(aa7,'Position');
        bb7(4)=bb7(4)+0.055;%%ertefa
        bb7(3)=bb7(3)+0.09;%%arz
        bb7(2)=bb7(2)+0.05;%%bala payin
        bb7(1)=bb7(1)-0.015;%%chap rast
        set(aa7,'Position',bb7);
        %%^^^^
        plot(yl2.Time(1:j),yl2.Data(:,1:j),'b',...
             yr3.Time(1:j),yr3.Data(:,1:j),'r','LineWidth',1.5);
        set(gca,'FontSize',16);
        xx1=legend('Local','Remote');
        set(xx1,'Interpreter','latex','fontsize',18);
        zz=ylabel('End-Effector in Y-direction');
        set(zz,'Interpreter','latex','fontsize',14);
        xlim([0 100]);
        ylim([0 3]);
        xlabel('Time(Sec.)','interpreter','latex','fontsize',17);
        %%^^^^
        frame = getframe(gcf);
        %frame = getframe; size bozorg neshun mide
        writeVideo(writerObj,frame);
end
close(writerObj);