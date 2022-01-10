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
    
    %����
    [X0,Y0,Z0]=sphere(40);
    surf(X0,Y0,Z0);%ͼ�����
    colormap(winter);%��ɫ
    shading interp%ʹɫ��ƽ������
    alpha(0.5);
    axis equal;%����������Ķ���ϵ�������ֵͬ ,����λ������ͬ
    axis off;
    set(gcf,'Color','w');%��������Ϊ��ɫ
    title(['The Best Route For ' num2str(n) ' Cities']);
    hold on;

    border = 0;
    %����
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
%     disp(['�ߵ����� ' num2str(border)]);
%     plot(X,Y,'ko','MarkerSize',12,'MarkerFaceColor',[1 1 0]);
end