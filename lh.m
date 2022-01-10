function lh(R,r0,p,q)
%lh������������p,q������ӻ�
%  R=1;r0=[0,0,0];p=[1,0,0];q=[0,1,0];
%Բ��O������
x0=r0(1);y0=r0(2);z0=r0(3);

%����P������
xp=p(1);yp=p(2);zp=p(3);

%����Q������
xq=q(1);yq=q(2);zq=q(3);

%����Բ����ƽ��ķ�����
a=(yp-y0)*(zq-z0)-(yq-y0)*(zp-z0);
b=(xq-x0)*(zp-z0)-(xp-x0)*(zq-z0);
c=(xp-x0)*(yq-y0)-(xq-x0)*(yp-y0);

%������ת�Ƕ�
if c>=0
  A=asin(b/sqrt(a^2+b^2+c^2));
  B=-asin(a/sqrt(a^2+c^2+eps));
else
  A=-asin(b/sqrt(a^2+b^2+c^2));
  B=asin(a/sqrt(a^2+c^2+eps));
end
C=0;

%��ת����
Ra=[1,0,0;0,cos(A),sin(A);0,-sin(A),cos(A)];
Rb=[cos(B),0,-sin(B);0,1,0;sin(B),0,cos(B)];
Rc=[cos(C),sin(C),0;-sin(C),cos(C),0;0,0,1];

%��ת�����
iRa=[1,0,0;0,cos(A),-sin(A);0,sin(A),cos(A)];
iRb=[cos(B),0,sin(B);0,1,0;-sin(B),0,cos(B)];
iRc=[cos(C),-sin(C),0;sin(C),cos(C),0;0,0,1];

%ƽ��p������
Rxp=xp-x0;
Ryp=yp-y0;
Rzp=zp-z0;

%ƽ��q������
Rxq=xq-x0;
Ryq=yq-y0;
Rzq=zq-z0;

%��תp,q������
Pxyz0=iRa*iRb*iRc*[Rxp;Ryp;Rzp];
Qxyz0=iRa*iRb*iRc*[Rxq;Ryq;Rzq];

%ȷ��p,q��Ĳ�������
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

%ȷ��������Χ
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

%�����ʼ����
x=R*cos(t);
y=R*sin(t);
z=zeros(1,length(t));

%������ת�������
Rxyz=Rc*Rb*Ra*[x;y;z];

%����ƽ�ƺ������
new(1,:)=Rxyz(1,:)+x0*ones(1,length(t));
new(2,:)=Rxyz(2,:)+y0*ones(1,length(t));
new(3,:)=Rxyz(3,:)+z0*ones(1,length(t));

%����ͼ��
plot3(new(1,:),new(2,:),new(3,:),'y',...
x0,y0,z0,'go',...
[xp,xq],[yp,yq],[zp,zq],'m.','MarkerSize',5,'MarkerFaceColor',[0 1 0])
grid on
axis equal