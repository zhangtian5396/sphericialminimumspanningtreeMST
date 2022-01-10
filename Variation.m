%% 子函数
%输   入：
%           pop              种群
%           VARIATIONRATE    变异率
%输   出：
%           pop              变异后的种群
%% 
function kidsPop = Variation(kidsPop,VARIATIONRATE,model)

for n=1:size(kidsPop,1)
    if rand<VARIATIONRATE
        temp = kidsPop(n,:);
        %找到变异位置
        location = ceil(length(temp)*rand);
        
        if location<=model.airship
            result = unidrnd(model.n*model.n);
            while any(temp==result)
                result = unidrnd(model.n*model.n);
            end
        else
            result = unidrnd(20);
            while any(temp==result)
                result = unidrnd(20);
            end
        end
        
        temp(location) = result;
        kidsPop(n,:) = temp;
    end
end