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

function A=CreateMatrixFromVector(x)

    k=numel(x);
    
    n=(sqrt(8*k+1)+1)/2;
    
    A=zeros(n,n);
    
    c=0;
    for i=1:n
        for j=i+1:n
            c=c+1;
            
            A(i,j)=x(c);
            A(j,i)=x(c);
        end
    end

end