load('F:\MST\data\iter\IMA\16_num9.mat')
model = loadmodel(16);
figure(1);
PlotSolution(IMAsol,model);
title('\fontsize{12}\bf The best route for 800 points');
pause(0.01);