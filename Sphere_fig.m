load('F:\MST\data\iter\IMA\13_num2.mat')
load('F:\MST\data\sol\IMA\13_num2.mat')
load('rand_500_cities.mat')
root=coordinates(1,:);
x=root(1);y=root(2);z=root(3);
% x0=x-0.01;y0=y-0.01;z0=z-0.01;
model = loadmodel(13);

figure(1);
PlotSolution(IMAsol,model);
hold on

plot3(x,y,z,'k.','MarkerSize',25)
text(x,y,z+0.1,'ROOT','FontWeight','Bold','FontSize',15);
title('\fontsize{12}\bf The best route for 500 points');
pause(0.01);