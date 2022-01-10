function lh(R,r0,p,q)
%lh函数用于连接p,q两点的劣弧
%  R=1;r0=[0,0,0];p=[1,0,0];q=[0,1,0];
%圆心O的坐标
x0=r0(1);y0=r0(2);z0=r0(3);

%定点P的坐标
xp=p(1);yp=p(2);zp=p(3);

%定点Q的坐标
xq=q(1);yq=q(2);zq=q(3);

%计算圆所在平面的法向量
a=(yp-y0)*(zq-z0)-(yq-y0)*(zp-z0);
b=(xq-x0)*(zp-z0)-(xp-x0)*(zq-z0);
c=(xp-x0)*(yq-y0)-(xq-x0)*(yp-y0);

%计算旋转角度
if c>=0
  A=asin(b/sqrt(a^2+b^2+c^2));
  B=-asin(a/sqrt(a^2+c^2+eps));
else
  A=-asin(b/sqrt(a^2+b^2+c^2));
  B=asin(a/sqrt(a^2+c^2+eps));
end
C=0;

%旋转矩阵
Ra=[1,0,0;0,cos(A),sin(A);0,-sin(A),cos(A)];
Rb=[cos(B),0,-sin(B);0,1,0;sin(B),0,cos(B)];
Rc=[cos(C),sin(C),0;-sin(C),cos(C),0;0,0,1];

%旋转逆矩阵
iRa=[1,0,0;0,cos(A),-sin(A);0,sin(A),cos(A)];
iRb=[cos(B),0,sin(B);0,1,0;-sin(B),0,cos(B)];
iRc=[cos(C),-sin(C),0;sin(C),cos(C),0;0,0,1];

%平移p点坐标
Rxp=xp-x0;
Ryp=yp-y0;
Rzp=zp-z0;

%平移q点坐标
Rxq=xq-x0;
Ryq=yq-y0;
Rzq=zq-z0;

%旋转p,q点坐标
Pxyz0=iRa*iRb*iRc*[Rxp;Ryp;Rzp];
Qxyz0=iRa*iRb*iRc*[Rxq;Ryq;Rzq];

%确定p,q点的参数坐标
if Pxyz0(1)>=0&Pxyz0(2)>=0
   tp=asin(Pxyz0(2)/R);
elseif Pxyz0(1)<0&Pxyz0(2)>=0
   tp=acos(Pxyz0(1)/R);
elseif Pxyz0(1)<0&Pxyz0(2)<0
   tp=pi-asin(Pxyz0(2)/R);
else
   tp=2*pi+asin(Pxyz0(2)/R);
end

if Qxyz0(1)>=0&Qxyz0(2)>=0
   tq=asin(Qxyz0(2)/R);
elseif Qxyz0(1)<0&Qxyz0(2)>=0
   tq=acos(Qxyz0(1)/R);
elseif Qxyz0(1)<0&Qxyz0(2)<0
   tq=pi-asin(Qxyz0(2)/R);
else
   tq=2*pi+asin(Qxyz0(2)/R);
end

%确定参数范围
if tp>=0&tp<=pi
  if tq-tp<=pi
    tmin=min(tp,tq);
    tmax=max(tp,tq);
    t=tmin:0.001:tmax;
  else
    t1=tq:0.001:2*pi;
    t2=0:0.001:tp;
    t=[t1,t2];
  end
else
  if tp-tq<=pi
    tmin=min(tp,tq);
    tmax=max(tp,tq);
    t=tmin:0.001:tmax;
  else
    t1=tp:0.001:2*pi;
    t2=0:0.001:tq;
    t=[t1,t2];
  end
end

%计算初始坐标
x=R*cos(t);
y=R*sin(t);
z=zeros(1,length(t));

%计算旋转后的坐标
Rxyz=Rc*Rb*Ra*[x;y;z];

%计算平移后的坐标
new(1,:)=Rxyz(1,:)+x0*ones(1,length(t));
new(2,:)=Rxyz(2,:)+y0*ones(1,length(t));
new(3,:)=Rxyz(3,:)+z0*ones(1,length(t));

%绘制图像
plot3(new(1,:),new(2,:),new(3,:),'y',...
x0,y0,z0,'go',...
[xp,xq],[yp,yq],[zp,zq],'m.','MarkerSize',5,'MarkerFaceColor',[0 1 0])
grid on
axis equal