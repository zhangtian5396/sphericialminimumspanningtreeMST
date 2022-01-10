% function createfigure(YMatrix1)
%CREATEFIGURE(YMatrix1)
%  YMATRIX1:  y 数据的矩阵

%  由 MATLAB 于 15-Oct-2021 19:35:08 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 使用 semilogy 的矩阵输入创建多行
semilogy1 = semilogy(YMatrix1,'LineWidth',1.5,'Parent',axes1);
set(semilogy1(1),'DisplayName','IMA','LineWidth',2,'Color',[0 0 0]);
set(semilogy1(2),'DisplayName','MA','Color',[0 0 1]);
set(semilogy1(3),'DisplayName','AEFA','Color',[1 0 1]);
set(semilogy1(4),'DisplayName','PSO','Color',[1 1 0]);
set(semilogy1(5),'DisplayName','ICA','Color',[0 1 0]);
set(semilogy1(6),'DisplayName','FA','Color',[0 1 1]);
set(semilogy1(7),'DisplayName','GA','Color',[1 0 0]);
set(semilogy1(8),'DisplayName','GOA','LineStyle','--','Color',[0 0 0]);
set(semilogy1(9),'DisplayName','GWO','LineStyle','--','Color',[0 0 1]);
set(semilogy1(10),'DisplayName','SOA','LineStyle',':','Color',[1 0 0]);
set(semilogy1(11),'DisplayName','SMA','LineStyle','-.','Color',[0 1 1]);

% 创建 ylabel
ylabel('Fitness Value');

% 创建 xlabel
xlabel('Iterations');

% 创建 title
title('The convergence curves of algorithms for 50 cities');

box(axes1,'on');
% 设置其余坐标区属性
set(axes1,'YMinorTick','on','YScale','log');
% 创建 legend
legend(axes1,'show');

