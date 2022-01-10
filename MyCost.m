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

function [z, sol]=MyCost(xhat,model)

    x=double(xhat>=0.5);

    d=model.d;

    A=CreateMatrixFromVector(x);
    
    q=CalcDisconnectivity(A);
    
    AD=A.*d;
    
    alpha=5*sum(d(:));
    
    SumAD=sum(AD(:));
    
    z=SumAD+alpha*q;
    
    sol.A=A;
    sol.q=q;
    sol.SumAD=SumAD;
    sol.z=z;
    sol.IsFeasible=(q==0);

end