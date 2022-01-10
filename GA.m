
function [bestsol,bestValues,meanbest] = GA(N,Maxit,model)

D = model.n-2;
%%遗传参数设置
NUMPOP=N;%初始种群大小
ITERATION = Maxit;%迭代次数
CROSSOVERRATE = 0.5;%杂交率
VARIATIONRATE = 0.8;%变异率

%初始化种群
for i=1:NUMPOP
    a = randperm(model.n);
    pop(i,:) = a(1:D);
end

bestValues = [];
meanbest = [];

bestsol = [];
bestfit = inf;

%开始迭代
for time=1:ITERATION
    %计算初始种群的适应度
    [fitness,sol]=m_Fitness(pop,model);
    [bestfitness,index] = min(fitness);
    if bestfit>bestfitness
        bestfit=bestfitness;
        bestpop = pop(index,:);
        bestsol = sol(index);
    end
    
    bestValues = [bestValues bestfit];
    meanbest = [meanbest mean(fitness)];
    
    %选择
    pop=m_Select(fitness,pop);
    %交叉
    pop = Crossover(pop,CROSSOVERRATE);
    %变异
    pop = Variation(pop,VARIATIONRATE,model);
    
%     figure(1);
%     plotsolGA(bestpop,model);
%     pause(0.01);

%     disp(['iter=' num2str(time) '最优解：' num2str(bestfit)]);
end
% disp(['最优解：' num2str(bestpop)]);
% disp(['最优覆盖率：' num2str(bestfit)]);
end


function [fitness,sol]=m_Fitness(pop,model)
%% Fitness Function
    for n=1:size(pop,1)
        [~,fitness(n,:),sol(n)]=MyCost_EOCAEFA(pop(n,:),model);
    end
end

function parentPop=m_Select(matrixFitness,pop)
    sumFitness=sum(matrixFitness(:));%计算所有种群的适应度
    accP=cumsum(matrixFitness/sumFitness);%累积概率
    %轮盘赌选择算法
    for n=1:size(pop,1)
        matrix=find(accP>rand); %找到比随机数大的累积概率
        if isempty(matrix)
            continue
        end
        parentPop(n,:)=pop(matrix(1),:);%将首个比随机数大的累积概率的位置的个体遗传下去
    end
end

function kidsPop = Crossover(parentsPop,CROSSOVERRATE)
    for n = 1 : size(parentsPop,1)
        %选择出交叉的父代和母代
        father = parentsPop(ceil((size(parentsPop,1)-1)*rand)+1,:);
        mother = parentsPop(ceil((size(parentsPop,1)-1)*rand)+1,:);
        %随机产生交叉位置
        crossLocation = ceil((length(father)-1)*rand)+1;
        %如果随即数比交叉率低，就杂交
        if rand<CROSSOVERRATE
            father(1,crossLocation:end) = mother(1,crossLocation:end);
        end
        kidsPop(n,:) = father;
    end
end

function kidsPop = Variation(kidsPop,VARIATIONRATE,model)
    for n=1:size(kidsPop,1)
        if rand<VARIATIONRATE
            temp = kidsPop(n,:);
            %找到变异位置
            location = ceil(length(temp)*rand);
            result = unidrnd(model.n);
            temp(location) = result;
            kidsPop(n,:) = temp;
        end
    end
end

