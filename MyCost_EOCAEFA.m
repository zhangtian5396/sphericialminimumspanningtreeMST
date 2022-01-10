%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP116
% Project Title: Minimum Spanning Tree using PSO, FA, ICA
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%
%输入：当前粒子的位置，全部节点位置
%输出：粒子位置，目标函数值（生成树代价），生成树的相关信息
function [xhat,z, sol]=MyCost_EOCAEFA(xhat,model)
    
    D.AV = [1:model.n];%从1到节点数的一行排列
    for kkk = 1:size(xhat,2)%size(xhat,2)是xhat的列数，即节点数-2
        aa = find(D.AV >= xhat(1,kkk),1,'first');%查找与D.AV >= xhat(1,kkk)对应的第一个索引
        bb = find(D.AV <= xhat(1,kkk),1,'last');%查找与D.AV <= xhat(1,kkk)对应的最后一个索引
        %即现在粒子中的第kkk个数在aa与bb中间
        if abs(D.AV(aa)-xhat(1,kkk)) < abs(D.AV(bb)-xhat(1,kkk))%第kkk个数更靠近哪个整数就变成哪个整数
            xhat(1,kkk) = D.AV(aa);
        else
            xhat(1,kkk) = D.AV(bb);
        end
    end

    cost = prufer(xhat);%当前树的连接方法
    A = zeros(model.n);%n*n个0
    for i = 1:model.n-1%cost一共节点数-1行，把能够连接起来的两个节点标上1
            A(cost(i,1),cost(i,2)) = 1;
            A(cost(i,2),cost(i,1)) = 1;
    end
    
    d=model.d;%两个节点间的距离

    AD=A.*d;%距离矩阵*0-1矩阵=实际上每两个连接的节点间的距离
   
    SumAD=sum(AD(:))/2;%连接的节点的距离之和，即生成树的代价
    
    z=SumAD;%生成树的代价
    sol.A=A;%0-1矩阵
    sol.SumAD=SumAD;%生成树的代价;
    sol.z=z;%生成树的代价
    sol.cost = cost;%生成树的节点连接方法

end