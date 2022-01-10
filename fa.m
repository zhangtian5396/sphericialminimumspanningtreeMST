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

function [BestSol,BestCost,meancost] = FA(N,Max_iter,model)

%% Problem Definition

% model=CreateModel();

CostFunction=@(xhat) MyCost_EOCAEFA(xhat,model);        % Cost Function

nVar=model.n-2;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=1;         % Lower Bound of Variables
VarMax=model.n;         % Upper Bound of Variables


%% Firefly Algorithm Parameters

MaxIt=Max_iter;         % Maximum Number of Iterations

nPop=N;            % Number of Fireflies (Swarm Size)

gamma=1;            % Light Absorption Coefficient

beta0=2;            % Attraction Coefficient Base Value

alpha=0.2;          % Mutation Coefficient

alpha_damp=0.98;    % Mutation Coefficient Damping Ratio

delta=0.05*(VarMax-VarMin);     % Uniform Mutation Range

m=2;

if isscalar(VarMin) && isscalar(VarMax)
    dmax = (VarMax-VarMin)*sqrt(nVar);
else
    dmax = norm(VarMax-VarMin);
end

nMutation = 2;      % Number of Additional Mutation Operations

mu = 0.1;           % Mutation Rate

%% Initialization

% Empty Firefly Structure
firefly.Position=[];
firefly.Cost=[];
firefly.Sol=[];

% Initialize Population Array
pop=repmat(firefly,nPop,1);

% Initialize Best Solution Ever Found
BestSol.Cost=inf;

% Create Initial Fireflies
for i=1:nPop
   pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
   [~,pop(i).Cost, pop(i).Sol]=CostFunction(pop(i).Position);
   
   if pop(i).Cost<=BestSol.Cost
       BestSol=pop(i);
   end
end

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);
meancost = [];
it = 1;
BestCost(it)=BestSol.Cost;
meancost = [meancost mean([pop(:).Cost])];

%% Firefly Algorithm Main Loop

for it=2:MaxIt
    
    newpop=repmat(firefly,nPop,1);
    for i=1:nPop
        newpop(i).Cost = inf;
        for j=1:nPop
            if pop(j).Cost < pop(i).Cost
                rij=norm(pop(i).Position-pop(j).Position)/dmax;
                beta=beta0*exp(-gamma*rij^m);
                e=delta*unifrnd(-1,+1,VarSize);
                %e=delta*randn(VarSize);
                
                newsol.Position = pop(i).Position ...
                                + beta*rand(VarSize).*(pop(j).Position-pop(i).Position) ...
                                + alpha*e;
                
                newsol.Position=max(newsol.Position,VarMin);
                newsol.Position=min(newsol.Position,VarMax);
                
                [~,newsol.Cost, newsol.Sol]=CostFunction(newsol.Position);
                
                if newsol.Cost <= newpop(i).Cost
                    newpop(i) = newsol;
                    if newpop(i).Cost<=BestSol.Cost
                        BestSol=newpop(i);
                    end
                end
                
            end
        end
        
        % Perform Mutation
%         for k=1:nMutation
%             newsol.Position = Mutate(pop(i).Position, mu);
%             [newsol.Cost, newsol.Sol]=CostFunction(newsol.Position);
%             if newsol.Cost <= newpop(i).Cost
%                 newpop(i) = newsol;
%                 if newpop(i).Cost<=BestSol.Cost
%                     BestSol=newpop(i);
%                 end
%             end
%         end
                
    end
    
    % Merge
    pop=[pop
         newpop];  %#ok
    
    % Sort
    [~, SortOrder]=sort([pop.Cost]);
    pop=pop(SortOrder);
    
    % Truncate
    pop=pop(1:nPop);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    meancost = [meancost mean([pop(:).Cost])];
    
    % Show Iteration Information
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Damp Mutation Coefficient
    alpha = alpha*alpha_damp;
    
%     figure(1);
%     PlotSolution(BestSol.Sol, model);
%     pause(0.01);

end

%% Results
% 
% figure;
% plot(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;
