% Project Title: A mayfly optimization algorithm (MA) in MATLAB
function [BestSol,BestValues]=MA_BB(nPop,MaxIt,model)
%% Problem Definition
ObjectiveFunction=@(xhat) MyCost_EOCAEFA(xhat,model);
dim=model.n-2;%维度=节点数-2
ProblemSize=[1 dim];             % Decision Variables Size
LowerBound = 1;                  %下界为1
UpperBound = model.n;            %上界为节点数
numsum=1;
result=zeros(numsum,1);
for num=1:numsum
%% Mayfly Parameters
% methname='Mayfly Algorithm';
% nPop=(nPop+2)/2;
nPopf=nPop;          % Population Size (males and females)
% Mating Parameters
nc=nPop;                      % Number of Offsprings (also Parnets)
% a1=1.0;                     % Personal Learning Coefficient
% a2=1.5; a3=1.5;             % Global Learning Coefficient
% beta=2;                     % Distance sight Coefficient
nm=round(0.05*nPop);        % Number of Mutants
mu=0.01;                    % Mutation Rate
%% Initialization
empty_mayfly.Position=[];
empty_mayfly.Cost=[];
empty_mayfly.Sol=[];
empty_mayfly.Best.Position=[];
empty_mayfly.Best.Cost=[];
empty_mayfly.Best.Sol=[];
Mayfly=repmat(empty_mayfly,nPop,1);   % Males
Mayflyf=repmat(empty_mayfly,nPopf,1); % Females
GlobalBest.Cost=inf;

funccount=0;
for i=1:nPop
    Mayfly(i).Position=unifrnd(LowerBound,UpperBound,ProblemSize);
    [Mayfly(i).Position,Mayfly(i).Cost,Mayfly(i).Sol]=ObjectiveFunction(Mayfly(i).Position);
    Mayfly(i).Best.Position=Mayfly(i).Position;
    Mayfly(i).Best.Cost=Mayfly(i).Cost;
    funccount=funccount+1;
    if Mayfly(i).Best.Cost<GlobalBest.Cost
        GlobalBest=Mayfly(i).Best;
    end
end
for i=1:nPopf
    Mayflyf(i).Position=unifrnd(LowerBound,UpperBound,ProblemSize);
    [Mayflyf(i).Position,Mayflyf(i).Cost,Mayflyf(i).Sol]=ObjectiveFunction(Mayflyf(i).Position);
    funccount=funccount+1;
end
BestValues=[];
%% Mayfly Main Loop
for it=1:MaxIt
    RL=0.05*levy(nPop,dim,1.5); 
    for i=1:nPopf
            if Mayflyf(i).Cost>Mayfly(i).Cost
                    for j=1:dim
                        u(i,j)=(Mayfly(i).Position(j)+Mayflyf(i).Position(j))./2;            
                        v(i,j)=abs(Mayfly(i).Position(j)-Mayflyf(i).Position(j));
                        Mayflyf(i).Position(j)=sqrt(v(i,j))*randn(1)+u(i,j);
                       if Mayflyf(i).Position(j)>UpperBound
                            Mayflyf(i).Position(j)=u(i,j)+(UpperBound-u(i,j)).^2./(Mayflyf(i).Position(j)-u(i,j));
                        end
                        if Mayflyf(i).Position(j)<LowerBound
                            Mayflyf(i).Position(j)=u(i,j)+(LowerBound-u(i,j)).^2./(Mayflyf(i).Position(j)-u(i,j));
                        end
                    end
            else
                for j=1:dim
                    u(i,j)=(Mayfly(i).Position(j)+Mayflyf(i).Position(j))./2;
                    Mayflyf(i).Position(j) = Mayflyf(i).Position(j)+Mayflyf(i).Position(j)*RL(i,j);
                    if Mayflyf(i).Position(j)>UpperBound
                        Mayflyf(i).Position(j)=u(i,j)+(UpperBound-u(i,j)).^2./(Mayflyf(i).Position(j)-u(i,j));
                    end
                    if Mayflyf(i).Position(j)<LowerBound
                        Mayflyf(i).Position(j)=u(i,j)+(LowerBound-u(i,j)).^2./(Mayflyf(i).Position(j)-u(i,j));
                    end
                end
            end
% 
%         Mayflyf(i).Position = max(Mayflyf(i).Position,LowerBound);
%         Mayflyf(i).Position = min(Mayflyf(i).Position,UpperBound);
        [Mayflyf(i).Position,Mayflyf(i).Cost,Mayflyf(i).Sol] = ObjectiveFunction(Mayflyf(i).Position);
        funccount=funccount+1;
    end
    for i=1:nPop

            if Mayfly(i).Cost>GlobalBest.Cost
                    for j=1:dim
                        if it<MaxIt/2
                             u(i,j)=(Mayfly(i).Best.Position(j)+GlobalBest.Position(j))./2;
                             v(i,j)=abs(GlobalBest.Position(j)-Mayfly(i).Best.Position(j));
                             Mayfly(i).Position(j)=sqrt(v(i,j))*randn(1)+u(i,j);
                        else
                            u(i,j)=(Mayfly(i).Best.Position(j)+GlobalBest.Position(j))./2;
                            seed=randperm(nPop);
                            k1=seed(1);k2=seed(2);
                            delta=rand*abs(Mayfly(k1).Position(j)-Mayfly(k2).Position(j)).*exp(GlobalBest.Cost-Mayfly(i).Cost);
                            v(i,j)=abs(GlobalBest.Position(j)-Mayfly(i).Best.Position(j))+delta;
                            Mayfly(i).Position(j)=v(i,j)*randn(1)+u(i,j);
                            
                        end
                        if Mayfly(i).Position(j)>UpperBound
                            Mayfly(i).Position(j)=u(i,j)+(UpperBound-u(i,j)).^2./(Mayfly(i).Position(j)-u(i,j));
                        end
                        if Mayfly(i).Position(j)<LowerBound
                            Mayfly(i).Position(j)=u(i,j)+(LowerBound-u(i,j)).^2./(Mayfly(i).Position(j)-u(i,j));
                        end
                    end
            else
                u(i,j)=(Mayfly(i).Best.Position(j)+GlobalBest.Position(j))./2;
                for j=1:dim
                    Mayfly(i).Position(j) = Mayfly(i).Position(j)+Mayfly(i).Position(j)*RL(i,j);
                    if Mayfly(i).Position(j)>UpperBound
                        Mayfly(i).Position(j)=u(i,j)+(UpperBound-u(i,j)).^2./(Mayfly(i).Position(j)-u(i,j));
                    end
                    if Mayfly(i).Position(j)<LowerBound
                        Mayfly(i).Position(j)=u(i,j)+(LowerBound-u(i,j)).^2./(Mayfly(i).Position(j)-u(i,j));
                    end
                end
            end
% 
%         Mayfly(i).Position = max(Mayfly(i).Position,LowerBound);
%         Mayfly(i).Position = min(Mayfly(i).Position,UpperBound);
        % Evaluation
       [Mayfly(i).Position,Mayfly(i).Cost,Mayfly(i).Sol] = ObjectiveFunction(Mayfly(i).Position);
        funccount=funccount+1;
        if Mayfly(i).Cost<Mayfly(i).Best.Cost
            Mayfly(i).Best.Position=Mayfly(i).Position;
            Mayfly(i).Best.Cost=Mayfly(i).Cost;Mayfly(i).Best.Sol=Mayfly(i).Sol;
            if Mayfly(i).Best.Cost<GlobalBest.Cost
                GlobalBest=Mayfly(i).Best;
            end
        end       
    end
    [~, SortMayflies]=sort([Mayfly.Cost]);
    Mayfly=Mayfly(SortMayflies);
    [~, SortMayflies]=sort([Mayflyf.Cost]);
    Mayflyf=Mayflyf(SortMayflies);

    % MATE
    MayflyOffspring=repmat(empty_mayfly,nc/2,2);
    for k=1:nc/2
        i1=k;
        i2=k;
        p1=Mayfly(i1);
        p2=Mayflyf(i2);
        % Apply Crossover
         [MayflyOffspring(k,1).Position, MayflyOffspring(k,2).Position]=Crossover(p1.Position,p2.Position,LowerBound,UpperBound);
        % Evaluate Offsprings
        [MayflyOffspring(k,1).Position,MayflyOffspring(k,1).Cost,MayflyOffspring(k,1).Sol]=ObjectiveFunction(MayflyOffspring(k,1).Position);
        if MayflyOffspring(k,1).Cost<GlobalBest.Cost
            GlobalBest=MayflyOffspring(k,1);
        end
        funccount=funccount+1;
        [MayflyOffspring(k,2).Position,MayflyOffspring(k,2).Cost,MayflyOffspring(k,2).Sol]=ObjectiveFunction(MayflyOffspring(k,2).Position);
        if MayflyOffspring(k,2).Cost<GlobalBest.Cost
            GlobalBest=MayflyOffspring(k,2);
        end
        funccount=funccount+1;
        MayflyOffspring(k,1).Best.Position = MayflyOffspring(k,1).Position;
        MayflyOffspring(k,1).Best.Cost = MayflyOffspring(k,1).Cost;
        MayflyOffspring(k,1).Best.Sol= MayflyOffspring(k,1).Sol;
        MayflyOffspring(k,2).Best.Position = MayflyOffspring(k,2).Position;
        MayflyOffspring(k,2).Best.Cost = MayflyOffspring(k,2).Cost;
        MayflyOffspring(k,2).Best.Sol= MayflyOffspring(k,2).Sol;
    end
    MayflyOffspring=MayflyOffspring(:);
    % Mutation
    MutMayflies=repmat(empty_mayfly,nm,1);
    for k=1:nm
        % Select Parent
        i=randi([1 nPop]);
        p=MayflyOffspring(i);
        %p=Mayfly(i);
        MutMayflies(k).Position=Mutate(p.Position,mu,LowerBound,UpperBound);
        % Evaluate Mutant
        [MutMayflies(k).Position,MutMayflies(k).Cost,MutMayflies(k).Sol]=ObjectiveFunction(MutMayflies(k).Position);
        if MutMayflies(k).Cost<GlobalBest.Cost
            GlobalBest=MutMayflies(k);
        end
        MutMayflies(k).Best.Position = MutMayflies(k).Position;
        MutMayflies(k).Best.Cost = MutMayflies(k).Cost;
        MutMayflies(k).Best.Sol = MutMayflies(k).Sol;
      
    end
    % Create Merged Population
    MayflyOffspring=[MayflyOffspring
        MutMayflies]; %#ok
    split=round((size(MayflyOffspring,1))/2);
    newmayflies=MayflyOffspring(1:split);
    Mayfly=[Mayfly
        newmayflies]; %#ok
    newmayflies=MayflyOffspring(split+1:size(MayflyOffspring,1));
    Mayflyf=[Mayflyf
        newmayflies]; %#ok
    [~, SortMayflies]=sort([Mayfly.Cost]);
    Mayfly=Mayfly(SortMayflies);
    Mayfly=Mayfly(1:nPop); % Keep best males
    [~, SortMayflies]=sort([Mayflyf.Cost]);
    Mayflyf=Mayflyf(SortMayflies);
    Mayflyf=Mayflyf(1:nPopf); % Keep best females
    BestSol=GlobalBest.Sol;
    BestValues=[BestValues GlobalBest.Cost];
    %disp([methname ' on the ' funcname  ' Function: Iteration = ' num2str(it)  ', ' funcname ', Evaluations = ' num2str(funccount)  '. Best Cost = ' num2str(BestSolution(it))]);
%     disp(['Iteration ' num2str(it) ': BestValues = ' num2str(BestValues(end))]);
%      figure(1);
%      if mod(it,100) == 0
% %     PlotSolution(BestSol,model);
% %     title('\fontsize{12}\bf The best route for 25 cities');
%      semilogy(BestValues(end),'k','LineWidth',2);hold on;
%      pause(0.01);
%      end
end
% figure(1);
% PlotSolution(BestSol,model);
% title('\fontsize{12}\bf The best route for 400 cities');
    %% Results
%     figure;
%     plot(BestValues,'LineWidth',2); semilogy(BestValues,'LineWidth',2);
%     xlabel('Iterations'); ylabel('Objective function'); grid on;
%     result(num,:)=BestValues(end);
end
% M=mean(result);
% B=min(result);
% W=max(result);
% STD=std(result);
% result=result';
% disp(['IMA运行' num2str(num) '次的最好结果为： ' num2str(B) '  最差结果为：' num2str(W) '  平均结果为：' num2str(M) '  标准差为：' num2str(STD)]);
% warning off MATLAB:xlswrite:AddSheet
% xlswrite('IMA_400.xlsx',result,'Sheet1');
% xlswrite('IMA_400.xlsx',B,'Sheet2','A1');xlswrite('IMA_400.xlsx',W,'Sheet2','B1');xlswrite('IMA_400.xlsx',M,'Sheet2','C1');xlswrite('IMA_400.xlsx',STD,'Sheet2','D1');
end
%% 交叉操作
function [off1, off2]=Crossover(x1,x2,LowerBound,UpperBound)
L=unifrnd(0,1,size(x1));                                  %20行1列的0到1的随机数
off1=L.*x1+(1-L).*x2;                                     %交叉得到后代1
off2=L.*x2+(1-L).*x1;                                     %交叉得到后代2
% Position Limits
off1=max(off1,LowerBound); off1=min(off1,UpperBound);     %位置的边界限制
off2=max(off2,LowerBound); off2=min(off2,UpperBound);
end
%% 变异操作
function y=Mutate(x,mu,LowerBound,UpperBound)
nVar=numel(x);                                            %x是第i只蜉蝣的位置，numel计算x中的元素个数，即nVar=50
nmu=ceil(mu*nVar);                                        %ceil为向上取正，即nmu=ceil（0.01*50）=1
j=randsample(nVar,nmu);                                   %randsample(n,k)是产生k个不相同的数1~n，这里是产生1个1到50的数
sigma(1:nVar)=0.1*(UpperBound-LowerBound);                %sigma是正态分布的标准差
y=x;
y(j)=x(j)+sigma(j).*(randn(size(j))');                     %对第i只蜉蝣的第j维进行更新位置
%randn：产生均值为0，方差σ^2 = 1，标准差σ = 1的正态分布的随机数或矩阵,size(j)= 1
%1,randn(size(j))产生一个1*1的随机数
y=max(y,LowerBound); y=min(y,UpperBound);                 %进行位置的边界控制
end