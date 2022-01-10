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

function PlotSolution(sol,model)

    X=model.X;
    Y=model.Y;
    Z=model.Z;
    n=model.n;
    
    A=sol.A;
    
    %画球
    [X0,Y0,Z0]=sphere(40);
    surf(X0,Y0,Z0);%图像出现
    colormap(winter);%上色
    shading interp%使色彩平滑过渡
    alpha(0.5);
    axis equal;%将横轴纵轴的定标系数设成相同值 ,即单位长度相同
    axis off;
    set(gcf,'Color','w');%背景设置为白色
    title(['The Best Route For ' num2str(n) ' Cities']);
    hold on;

    border = 0;
    %连线
    for i=1:n
        for j=i+1:n
            if A(i,j)~=0
                lh(1,[0 0 0],[X(i),Y(i),Z(i)],[X(j),Y(j),Z(j)]);
                border = border + 1;
                hold on;
            end
        end
    end
    hold off;
%     disp(['边的条数 ' num2str(border)]);
%     plot(X,Y,'ko','MarkerSize',12,'MarkerFaceColor',[1 1 0]);
end