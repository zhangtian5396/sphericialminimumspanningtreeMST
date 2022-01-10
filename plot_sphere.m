%%ª≠Õº È±æ
[X0,Y0,Z0]=sphere(30);
surf(X0,Y0,Z0);
colormap(jet);
shading interp
% shading flat
alpha(0.5);
axis equal, axis on
% grid off
set(gcf,'Color','w');


for i=1:10
    hold on;
    lh(1,[0 0 0],uv2xyz(rand(),rand(),1),uv2xyz(rand(),rand(),1));
end