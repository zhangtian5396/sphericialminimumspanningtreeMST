% function createfigure(YMatrix1)
%CREATEFIGURE(YMatrix1)
%  YMATRIX1:  y ���ݵľ���

%  �� MATLAB �� 15-Oct-2021 19:35:08 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ʹ�� semilogy �ľ������봴������
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

% ���� ylabel
ylabel('Fitness Value');

% ���� xlabel
xlabel('Iterations');

% ���� title
title('The convergence curves of algorithms for 50 cities');

box(axes1,'on');
% ������������������
set(axes1,'YMinorTick','on','YScale','log');
% ���� legend
legend(axes1,'show');

