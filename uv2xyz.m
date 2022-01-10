function coordinates=uv2xyz(u,v,r)
len=size(u,2);
x=r*cos(2*pi.*u).*sin(pi.*v);
y=r*sin(2*pi.*u).*sin(pi.*v);
z=r*cos(pi.*v);
coordinates=[x',y',z'];
end