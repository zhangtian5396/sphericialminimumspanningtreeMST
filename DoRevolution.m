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

function emp=DoRevolution(emp)

    global ProblemSettings;
    CostFunction=ProblemSettings.CostFunction;
    nVar=ProblemSettings.nVar;
    VarSize=ProblemSettings.VarSize;
    VarMin=ProblemSettings.VarMin;
    VarMax=ProblemSettings.VarMax;
    
    global ICASettings;
    pRevolution=ICASettings.pRevolution;
    mu=ICASettings.mu;
        
    nEmp=numel(emp);
%     for k=1:nEmp
        
%         NewImp.Position = Mutate(emp(k).Imp.Position, mu);
%         [NewImp.Cost, NewImp.Sol]=CostFunction(NewImp.Position);
        
%         if NewImp.Cost<emp(k).Imp.Cost
%             emp(k).Imp = NewImp;
%         end
        
%         for i=1:emp(k).nCol
%             if rand<=pRevolution
%                 emp(k).Col(i).Position = Mutate(emp(k).Col(i).Position,mu);
%                 [emp(k).Col(i).Cost, emp(k).Col(i).Sol]= CostFunction(emp(k).Col(i).Position);
%             end
%         end
%     end

end