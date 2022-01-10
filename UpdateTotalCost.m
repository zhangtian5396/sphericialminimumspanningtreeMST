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

function emp=UpdateTotalCost(emp)

    global ICASettings;
    zeta=ICASettings.zeta;
    
    nEmp=numel(emp);
    
    for k=1:nEmp
        if emp(k).nCol>0
            emp(k).TotalCost=emp(k).Imp.Cost+zeta*mean([emp(k).Col.Cost]);
        else
            emp(k).TotalCost=emp(k).Imp.Cost;
        end
    end

end