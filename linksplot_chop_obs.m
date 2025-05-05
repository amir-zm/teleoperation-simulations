clc
close;
figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'color','white');
%set(gca,'un','n','pos',[0.06,0.12,0.92,0.85]);
aa1=subplot(2,2,[1,3]);
bb1=get(aa1,'Position');
bb1(4)=bb1(4);%%ertefa
bb1(3)=bb1(3)+0.12;%%arz
bb1(2)=bb1(2)+0.01;%%bala payin
bb1(1)=bb1(1)-0.077;%%chap rast
set(aa1,'Position',bb1);
a=size(xl1.Data(:));
z=55;
r=0.1;
R=0.2;
x0=0.05;
y0=0.35;
for i=1:z:a(1)
    ar=[0 xr1.Data(i) xr2.Data(i) xr3.Data(i)];
    br=[0 yr1.Data(i) yr2.Data(i) yr3.Data(i)];
    h2=plot(ar,br,'r','LineWidth',1);
    hold on;
end
ari=[0 xr1.Data(i) xr2.Data(i) xr3.Data(i)];
bri=[0 yr1.Data(i) yr2.Data(i) yr3.Data(i)];
h6=plot(ari,bri,'k','LineWidth',4);
hold on;
ar1=[0 xr1.Data(1) xr2.Data(1) xr3.Data(1)];
br1=[0 yr1.Data(1) yr2.Data(1) yr3.Data(1)];
h7=plot(ar1,br1,'k--','LineWidth',4);
hold on;
h4=plot(xr3.Data(:),yr3.Data(:),'g-.','LineWidth',4);
hold on;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x0;
yunit =  r * sin(th) + y0;
xunit1 = R * cos(th) + x0;
yunit1 =  R * sin(th) + y0;
plot(xunit, yunit,'b--','LineWidth',1.5);
hold on;
h = plot(xunit1, yunit1,'b--','LineWidth',1.5);
hold on;
plot(0.3,1.1,'k*');
hold on;
xx=legend([h2 h4 h7 h6],{'Remote robot',...
    'Trajectory of the end-effector',...
    'Initial configuration of the remote robot',...
    'Final configuration of the remote robot'});
set(xx,'interpreter','latex','fontsize',17);
%%%
%%%
string='$\bf X_{0}=\left(0.3m,1.1m\right)$';
ss=text(1.9,3.5,string);
set(ss,'Interpreter','latex','fontsize',16);
hold on
%%%
string='$\bf r=0.35m$';
ss=text(1.9,3.3,string);
set(ss,'Interpreter','latex','fontsize',16);
hold on;
%%%
string='$\bf R=0.7m$';
ss=text(1.9,3.1,string);
set(ss,'Interpreter','latex','fontsize',16);
hold on;
%%%
string='$\bf X_{0}$';
ss=text(-1,1.1,string);
set(ss,'Interpreter','latex','fontsize',16);
set(gca,'FontSize',17 ...
    ,'xlim',[-1 1] ...
    ,'ylim',[0 2]);
xlabel('X-direction(m.)','interpreter','latex','fontsize',17);
ylabel('Y-direction(m.)','interpreter','latex','fontsize',17);
%%%%%%%%%%%%%%%%%%%%%  2222222222
aa4=subplot(2,2,2);
bb4=get(aa4,'Position');
%bb4(4)=bb4(4)+0.055;%%ertefa
bb4(3)=bb4(3)+0.09;%%arz
bb4(2)=bb4(2)+0.01;%%bala payin
bb4(1)=bb4(1)-0.015;%%chap rast
set(aa4,'Position',bb4);
h1=plot(subtask_eq1,'r','LineWidth',1.5);
hold on;
h2=plot(subtask_eq2,'b--','LineWidth',1.5);
hold on;
h3=plot(subtask_eq3,'k-.','LineWidth',1.5);
xx=legend([h1 h2 h3],{'First joint',...
    'Second joint',...
    'Third joint'},'interpreter','latex','fontsize',17);
%set(xx,'interpreter','latex','fontsize',17);
set(gca,'FontSize',17 ...
    ,'xlim',[-0.02 100] ...
    ,'ylim',[-0.009 0.011]);
title('');
ylabel('\bf Sub-Task Tracking Error','interpreter','latex','fontsize',16);
xlabel('Time(Sec.)','interpreter','latex','fontsize',17);
%%%%%%%%%%%%%%%%%%%%%%% 333333333333333333
aa7=subplot(2,2,4);
bb7=get(aa7,'Position');
bb7(4)=bb7(4)+0.055;%%ertefa
bb7(3)=bb7(3)+0.09;%%arz
bb7(2)=bb7(2);%%bala payin
bb7(1)=bb7(1)-0.015;%%chap rast
set(aa7,'Position',bb7);
%%%
h1=plot(taskspace_ex,'r--','LineWidth',1.5);
hold on;
h2=plot(taskspace_ey,'b','LineWidth',1.5);
hold on;
legend([h1 h2],{'X-direction',...
    'Y-direction'},'interpreter','latex','fontsize',17);
set(gca,'FontSize',17 ...
    ,'xlim',[0 100] ...
    ,'ylim',[-5 2]);
title('');
ylabel('\bf Task-Space Tracking Error','interpreter','latex','fontsize',16);
xlabel('Time(Sec.)','interpreter','latex','fontsize',17);