
clc;clear all;
%·Ö×ÓÊý
Nf=1000;
%°ë¾¶
R=1;

sita=pi*rand(1,Nf);
fai=2*pi*rand(1,Nf);
x=R*(sin(sita).*cos(fai));
y=R*(sin(sita).*sin(fai));
z=R*cos(sita);
XYZ=[x' y' z'];
plot3(x,y,z,'r*')
axis equal
coordinates=XYZ;
save('rand_1000_cities','coordinates');