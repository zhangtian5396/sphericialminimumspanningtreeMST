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

function [y,x,sol] = Mutate(y, x,model)

%     if rand<1
        temp = x;
        %ÕÒµ½±äÒìÎ»ÖÃ
        location = ceil(length(temp)*rand);
        
        result = unidrnd(length(temp)+2);
%         while any(temp==result)
%             result = unidrnd(length(temp));
%         end
        
        temp(location) = result;
        [~,fitness,sol] = MyCost_EOCAEFA(temp,model);
        if fitness < y
            y = fitness;
            x = temp;
        end
%     end

end
