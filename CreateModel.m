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

function model=CreateModel()

    %X=[14 42 50  7 36 87 96 50 11 21 36 14 81 39 11 59 78 89 11];
    %Y=[63 52 93 83 25 99  6  4 10 43 93 82 71 24 74  9 81 46 36];
    
%     for i = 1:50
%         X(i) = rand();
%         Y(i) = rand();
%     end
    
    [X,Y,Z,D]=distance(10);
%     X = [80 0 60 0 100 20 60 20 0 40 80 40 20 80 60 0 40 20 80 20];
%     Y = [20 60 0 40 60 80 80 0 80 80 100 100 20 40 20 100 20 40 80 100];

    n=numel(X);
    
%     d=zeros(n,n);
%     
%     for i=1:n
%         for j=i+1:n
%             d(i,j)=sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
%             d(j,i)=d(i,j);
%         end
%     end
    
    model.n=n;
    model.X=X;
    model.Y=Y;
    model.Z=Z;
    model.d=D;

end