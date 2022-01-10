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

function [BestSol,BestCost,meancost] = PSO(N,Max_iter,model)
%% Problem Definition

% model=CreateModel();
% model = loadmodel(2);

% CostFunction=@(xhat) MyCost(xhat,model);        % Cost Function
% 
% nVar=model.n*(model.n-1)/2;             % Number of Decision Variables

CostFunction=@(xhat) MyCost_EOCAEFA(xhat,model);        % Cost Function

nVar=model.n-2;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=1;         % Lower Bound of Variables
VarMax=model.n;         % Upper Bound of Variables


%% PSO Parameters

MaxIt=Max_iter;      % Maximum Number of Iterations

nPop=N;       % Population Size (Swarm Size)

w=0.2;              % Inertia Weight
wdamp=1;            % Inertia Weight Damping Ratio
c1=0.7;             % Personal Learning Coefficient
c2=1.0;             % Global Learning Coefficient

% Velocity Limits
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;

mu = 0.1;      % Mutation Rate

%% Initialization

empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Sol=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
empty_particle.Best.Sol=[];

particle=repmat(empty_particle,nPop,1);

BestSol.Cost=inf;

BestCost=zeros(MaxIt,1);
meancost = [];

for i=1:nPop
    
    % Initialize Position
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    particle(i).Velocity=zeros(VarSize);
    
    % Evaluation
    [~,particle(i).Cost, particle(i).Sol]=CostFunction(particle(i).Position);
    
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    particle(i).Best.Sol=particle(i).Sol;
    
    % Update Global Best
    if particle(i).Best.Cost<BestSol.Cost
        
        BestSol=particle(i).Best;
        
    end
    
end

it = 1;
BestCost(it)=BestSol.Cost;
meancost = [meancost mean([particle(:).Cost])];
%% PSO Main Loop

for it=2:MaxIt
    
    for i=1:nPop
        
        % Update Velocity
        particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(BestSol.Position-particle(i).Position);
        
        % Apply Velocity Limits
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        
        % Update Position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Velocity Mirror Effect
        IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
        
        % Apply Position Limits
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        
        % Evaluation
        [~,particle(i).Cost, particle(i).Sol] = CostFunction(particle(i).Position);
        
%         % Mutation
%         for k=1:2
%             NewParticle=particle(i);
%             NewParticle.Position=Mutate(particle(i).Position, mu);
%             [NewParticle.Cost, NewParticle.Sol]=CostFunction(NewParticle.Position);
%             if NewParticle.Cost<=particle(i).Cost || rand < 0.1
%                 particle(i)=NewParticle;
%             end
%         end
        
        % Update Personal Best
        if particle(i).Cost<particle(i).Best.Cost
            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            particle(i).Best.Sol=particle(i).Sol;
            
            % Update Global Best
            if particle(i).Best.Cost<BestSol.Cost
                
                BestSol=particle(i).Best;
                
            end
            
        end
        
    end
    
%     % Local Search based on Mutation
%     for k=1:5
%         NewParticle=BestSol;
%         NewParticle.Position=Mutate(BestSol.Position, mu);
%         [NewParticle.Cost, NewParticle.Sol]=CostFunction(NewParticle.Position);
%         if NewParticle.Cost<=BestSol.Cost
%             BestSol=NewParticle;
%         end
%     end    
    
    BestCost(it)=BestSol.Cost;
    meancost = [meancost mean([particle(:).Cost])];
    
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    w=w*wdamp;
    
    % Plot Best Solution
%     figure(1);
%     PlotSolution(BestSol.Sol,model);
%     pause(0.01);
    
end

%% Results
% figure(1);
% PlotSolution(BestSol.Sol,model);
% 
% figure;
% plot(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');

