% Project Title: A mayfly optimization algorithm (MA) in MATLAB
function [BestSol,BestValues]=MA(nPop,MaxIt,model)
%% Problem Definition
ObjectiveFunction=@(xhat) MyCost_EOCAEFA(xhat,model);
dim=model.n-2;%ά��=�ڵ���-2
ProblemSize=[1 dim];             % Decision Variables Size
LowerBound = 1;                  %�½�Ϊ1
UpperBound = model.n;            %�Ͻ�Ϊ�ڵ���
numsum=1;
result=zeros(numsum,1);
for num=1:numsum
%% Mayfly Parameters
% methname='Mayfly Algorithm';
% nPop=(nPop+2)/2;
nPopf=nPop;          % Population Size (males and females)
g=0.8;                      % Inertia Weight
gdamp=0.95;                    % Inertia Weight Damping Ratio
a1=1.0;                     % Personal Learning Coefficient
a2=1.5; a3=1.5;             % Global Learning Coefficient
beta=2;                     % Distance sight Coefficient
dance=0.1;                    % Nuptial Dance
fl=0.1;                       % Random flight
dance_damp=0.77;             % Damping Ratio
fl_damp=0.77;
% Mating Parameters
nc=nPop;                      % Number of Offsprings (also Parnets)
nm=round(0.05*nPop);        % Number of Mutants
mu=0.01;                    % Mutation Rate
% Velocity Limits
VelMax=0.1*(UpperBound-LowerBound); VelMin=-VelMax;
%% Initialization
empty_mayfly.Position=[];
empty_mayfly.Cost=[];
empty_mayfly.Velocity=[];
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
    Mayfly(i).Velocity=zeros(ProblemSize);
    [Mayfly(i).Position,Mayfly(i).Cost,Mayfly(i).Sol]=ObjectiveFunction(Mayfly(i).Position);
    % Update Personal Best
    Mayfly(i).Best.Position=Mayfly(i).Position;
    Mayfly(i).Best.Cost=Mayfly(i).Cost;
    funccount=funccount+1;
    % Update Global Best
    if Mayfly(i).Best.Cost<GlobalBest.Cost
        GlobalBest=Mayfly(i).Best;
    end
end
for i=1:nPopf
    Mayflyf(i).Position=unifrnd(LowerBound,UpperBound,ProblemSize);
    Mayflyf(i).Velocity=zeros(ProblemSize);
    [Mayflyf(i).Position,Mayflyf(i).Cost,Mayflyf(i).Sol]=ObjectiveFunction(Mayflyf(i).Position);
    funccount=funccount+1;
    % Update Global Best (Uncomment if you use the PGB-IMA version)
    %if Mayflyf(i).Best.Cost<GlobalBest.Cost
    %    GlobalBest=Mayflyf(i).Best;
    %end
end
BestValues=[];
%% Mayfly Main Loop
for it=1:MaxIt
    for i=1:nPopf
        % Update Females
        e=unifrnd(-1,+1,ProblemSize);
        rmf=(Mayfly(i).Position-Mayflyf(i).Position);
        if Mayflyf(i).Cost>Mayfly(i).Cost
            Mayflyf(i).Velocity = g*Mayflyf(i).Velocity ...
                +a3*exp(-beta.*rmf.^2).*(Mayfly(i).Position-Mayflyf(i).Position);
        else
            Mayflyf(i).Velocity = g*Mayflyf(i).Velocity+fl*(e);
        end
        % Apply Velocity Limits
        Mayflyf(i).Velocity = max(Mayflyf(i).Velocity,VelMin);
        Mayflyf(i).Velocity = min(Mayflyf(i).Velocity,VelMax);
        % Update Position
        Mayflyf(i).Position = Mayflyf(i).Position + Mayflyf(i).Velocity;
        % Velocity Mirror Effect
        %IsOutside=(Mayflyf(i).Position<LowerBound | Mayflyf(i).Position>UpperBound);
        %Mayflyf(i).Velocity(IsOutside)=-Mayflyf(i).Velocity(IsOutside);
        % Position Limits
        Mayflyf(i).Position = max(Mayflyf(i).Position,LowerBound);
        Mayflyf(i).Position = min(Mayflyf(i).Position,UpperBound);
        % Evaluation
        [Mayflyf(i).Position,Mayflyf(i).Cost,Mayflyf(i).Sol] = ObjectiveFunction(Mayflyf(i).Position);
        funccount=funccount+1;
        % Update Global Best (Uncomment if you use the PGB-IMA version)
        %if Mayflyf(i).Best.Cost<GlobalBest.Cost
        %    GlobalBest=Mayflyf(i).Best;
        %end
    end
    for i=1:nPop
        % Update Males
        rpbest=(Mayfly(i).Best.Position-Mayfly(i).Position);
        rgbest=(GlobalBest.Position-Mayfly(i).Position);
        e=unifrnd(-1,+1,ProblemSize);
        % Update Velocity
        if Mayfly(i).Cost>GlobalBest.Cost
            Mayfly(i).Velocity = g*Mayfly(i).Velocity ...
                +a1*exp(-beta.*rpbest.^2).*(Mayfly(i).Best.Position-Mayfly(i).Position) ...
                +a2*exp(-beta.*rgbest.^2).*(GlobalBest.Position-Mayfly(i).Position);
        else
            Mayfly(i).Velocity = g*Mayfly(i).Velocity+dance*(e);
        end
        % Apply Velocity Limits
        Mayfly(i).Velocity = max(Mayfly(i).Velocity,VelMin);
        Mayfly(i).Velocity = min(Mayfly(i).Velocity,VelMax);
        % Update Position
        Mayfly(i).Position = Mayfly(i).Position + Mayfly(i).Velocity;
        % Velocity Mirror Effect
        %IsOutside=(Mayfly(i).Position<LowerBound | Mayfly(i).Position>UpperBound);
        %Mayfly(i).Velocity(IsOutside)=-Mayfly(i).Velocity(IsOutside);
        % Position Limits
        Mayfly(i).Position = max(Mayfly(i).Position,LowerBound);
        Mayfly(i).Position = min(Mayfly(i).Position,UpperBound);
        % Evaluation
       [Mayfly(i).Position,Mayfly(i).Cost,Mayfly(i).Sol] = ObjectiveFunction(Mayfly(i).Position);
        funccount=funccount+1;
        % Update Personal Best
        if Mayfly(i).Cost<Mayfly(i).Best.Cost
            Mayfly(i).Best.Position=Mayfly(i).Position;
            Mayfly(i).Best.Cost=Mayfly(i).Cost;Mayfly(i).Best.Sol=Mayfly(i).Sol;
            % Update Global Best
            if Mayfly(i).Best.Cost<GlobalBest.Cost
                GlobalBest=Mayfly(i).Best;
            end
        end
    end
%     [~, SortMayflies]=sort([Mayfly.Cost]);
%     Mayfly=Mayfly(SortMayflies);
%     [~, SortMayflies]=sort([Mayflyf.Cost]);
%     Mayflyf=Mayflyf(SortMayflies);
    % MATE
    MayflyOffspring=repmat(empty_mayfly,nc/2,2);
    for k=1:nc/2
        % Select Parents
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
        MayflyOffspring(k,1).Velocity= zeros(ProblemSize);
        MayflyOffspring(k,1).Best.Sol= MayflyOffspring(k,1).Sol;
        MayflyOffspring(k,2).Best.Position = MayflyOffspring(k,2).Position;
        MayflyOffspring(k,2).Best.Cost = MayflyOffspring(k,2).Cost;
        MayflyOffspring(k,2).Velocity= zeros(ProblemSize);
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
        MutMayflies(k).Velocity= zeros(ProblemSize);
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
    g=g*gdamp;
    dance = dance*dance_damp;
    fl = fl*fl_damp;
%     disp(['Iteration ' num2str(it) ': BestValues = ' num2str(BestValues(end))]);
%     figure(1);
%     PlotSolution(BestSol,model);
%     pause(0.01);
end

    %% Results
%     figure;
%     plot(BestValues,'LineWidth',2); semilogy(BestValues,'LineWidth',2);
%     xlabel('Iterations'); ylabel('Objective function'); grid on;
% 
%     result(num,:)=BestValues(end);
end
% M=mean(result);
% B=min(result);
% W=max(result);
% STD=std(result);
% disp(['MA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B) '  �����Ϊ��' num2str(W) '  ƽ�����Ϊ��' num2str(M) '  ��׼��Ϊ��' num2str(STD)]);
% result=result';
% warning off MATLAB:xlswrite:AddSheet
% xlswrite('MA_250.xlsx',result,'Sheet1');
% xlswrite('MA_250.xlsx',B,'Sheet2','A1');xlswrite('MA_250.xlsx',W,'Sheet2','B1');xlswrite('MA_250.xlsx',M,'Sheet2','C1');xlswrite('MA_250.xlsx',STD,'Sheet2','D1');

end
%% �������
function [off1, off2]=Crossover(x1,x2,LowerBound,UpperBound)
L=unifrnd(0,1,size(x1));                                  %20��1�е�0��1�������
off1=L.*x1+(1-L).*x2;                                     %����õ����1
off2=L.*x2+(1-L).*x1;                                     %����õ����2
% Position Limits
off1=max(off1,LowerBound); off1=min(off1,UpperBound);     %λ�õı߽�����
off2=max(off2,LowerBound); off2=min(off2,UpperBound);
end
%% �������
function y=Mutate(x,mu,LowerBound,UpperBound)
nVar=numel(x);                                            %x�ǵ�iֻ������λ�ã�numel����x�е�Ԫ�ظ�������nVar=50
nmu=ceil(mu*nVar);                                        %ceilΪ����ȡ������nmu=ceil��0.01*50��=1
j=randsample(nVar,nmu);                                   %randsample(n,k)�ǲ���k������ͬ����1~n�������ǲ���1��1��50����
sigma(1:nVar)=0.1*(UpperBound-LowerBound);                %sigma����̬�ֲ��ı�׼��
y=x;
y(j)=x(j)+sigma(j).*(randn(size(j))');                     %�Ե�iֻ�����ĵ�jά���и���λ��
%randn��������ֵΪ0�������^2 = 1����׼��� = 1����̬�ֲ�������������,size(j)= 1
%1,randn(size(j))����һ��1*1�������
y=max(y,LowerBound); y=min(y,UpperBound);                 %����λ�õı߽����
end