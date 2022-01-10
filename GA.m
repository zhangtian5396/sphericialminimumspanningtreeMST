
function [bestsol,bestValues,meanbest] = GA(N,Maxit,model)

D = model.n-2;
%%�Ŵ���������
NUMPOP=N;%��ʼ��Ⱥ��С
ITERATION = Maxit;%��������
CROSSOVERRATE = 0.5;%�ӽ���
VARIATIONRATE = 0.8;%������

%��ʼ����Ⱥ
for i=1:NUMPOP
    a = randperm(model.n);
    pop(i,:) = a(1:D);
end

bestValues = [];
meanbest = [];

bestsol = [];
bestfit = inf;

%��ʼ����
for time=1:ITERATION
    %�����ʼ��Ⱥ����Ӧ��
    [fitness,sol]=m_Fitness(pop,model);
    [bestfitness,index] = min(fitness);
    if bestfit>bestfitness
        bestfit=bestfitness;
        bestpop = pop(index,:);
        bestsol = sol(index);
    end
    
    bestValues = [bestValues bestfit];
    meanbest = [meanbest mean(fitness)];
    
    %ѡ��
    pop=m_Select(fitness,pop);
    %����
    pop = Crossover(pop,CROSSOVERRATE);
    %����
    pop = Variation(pop,VARIATIONRATE,model);
    
%     figure(1);
%     plotsolGA(bestpop,model);
%     pause(0.01);

%     disp(['iter=' num2str(time) '���Ž⣺' num2str(bestfit)]);
end
% disp(['���Ž⣺' num2str(bestpop)]);
% disp(['���Ÿ����ʣ�' num2str(bestfit)]);
end


function [fitness,sol]=m_Fitness(pop,model)
%% Fitness Function
    for n=1:size(pop,1)
        [~,fitness(n,:),sol(n)]=MyCost_EOCAEFA(pop(n,:),model);
    end
end

function parentPop=m_Select(matrixFitness,pop)
    sumFitness=sum(matrixFitness(:));%����������Ⱥ����Ӧ��
    accP=cumsum(matrixFitness/sumFitness);%�ۻ�����
    %���̶�ѡ���㷨
    for n=1:size(pop,1)
        matrix=find(accP>rand); %�ҵ������������ۻ�����
        if isempty(matrix)
            continue
        end
        parentPop(n,:)=pop(matrix(1),:);%���׸������������ۻ����ʵ�λ�õĸ����Ŵ���ȥ
    end
end

function kidsPop = Crossover(parentsPop,CROSSOVERRATE)
    for n = 1 : size(parentsPop,1)
        %ѡ�������ĸ�����ĸ��
        father = parentsPop(ceil((size(parentsPop,1)-1)*rand)+1,:);
        mother = parentsPop(ceil((size(parentsPop,1)-1)*rand)+1,:);
        %�����������λ��
        crossLocation = ceil((length(father)-1)*rand)+1;
        %����漴���Ƚ����ʵͣ����ӽ�
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
            %�ҵ�����λ��
            location = ceil(length(temp)*rand);
            result = unidrnd(model.n);
            temp(location) = result;
            kidsPop(n,:) = temp;
        end
    end
end

