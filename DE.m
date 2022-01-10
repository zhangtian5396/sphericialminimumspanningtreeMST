function [BestSolSol,BestCost]=DE(nPop,MaxIt,model)
%% Problem Definition

CostFunction=@(xhat) MyCost_EOCAEFA(xhat,model);    % Cost Function
dim=model.n-2;%维度=节点数-2
nVar=dim;
VarSize=[1 nVar];   % Decision Variables Matrix Size
VarMin=1;          % Lower Bound of Decision Variables
VarMax=model.n;          % Upper Bound of Decision Variables

%% DE Parameters

beta_min=0.2;   % Lower Bound of Scaling Factor
beta_max=0.8;   % Upper Bound of Scaling Factor

pCR=0.2;        % Crossover Probability

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];

BestSol.Cost=inf;

pop=repmat(empty_individual,nPop,1);

for i=1:nPop

    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    [pop(i).Position,pop(i).Cost,Sol]=CostFunction(pop(i).Position);
    
    if pop(i).Cost<BestSol.Cost
        BestSol=pop(i);
        BestSolSol=Sol;
    end
    
end

BestCost=zeros(MaxIt,1);

%% DE Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        x=pop(i).Position;
        
        A=randperm(nPop);
        
        A(A==i)=[];
        
        a=A(1);
        b=A(2);
        c=A(3);
        
        % Mutation
        %beta=unifrnd(beta_min,beta_max);
        beta=unifrnd(beta_min,beta_max,VarSize);
        y=pop(a).Position+beta.*(pop(b).Position-pop(c).Position);
        y = max(y, VarMin);
		y = min(y, VarMax);
		
        % Crossover
        z=zeros(size(x));
        j0=randi([1 numel(x)]);
        for j=1:numel(x)
            if j==j0 || rand<=pCR
                z(j)=y(j);
            else
                z(j)=x(j);
            end
        end
        
        NewSol.Position=z;
        NewSol.Cost=CostFunction(NewSol.Position);
        [NewSol.Position,NewSol.Cost,Sol]=CostFunction(NewSol.Position);
        
        if NewSol.Cost<pop(i).Cost
            pop(i)=NewSol;
            
            if pop(i).Cost<BestSol.Cost
               BestSol=pop(i);
               BestSolSol=Sol;
            end
        end
        
    end
    
    % Update Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end

%% Show Results
% 
% figure;
% %plot(BestCost);
% semilogy(BestCost, 'LineWidth', 2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;
