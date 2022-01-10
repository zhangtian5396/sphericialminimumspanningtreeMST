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

function [BestSol,BestCost,meancost] = ICA(N,Max_iter,model)
%% Problem Definition

% model=CreateModel();

CostFunction=@(xhat) MyCost_EOCAEFA(xhat,model);        % Cost Function

nVar=model.n-2;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=1;         % Lower Bound of Variables
VarMax=model.n;         % Upper Bound of Variables


%% ICA Parameters

MaxIt=Max_iter;          % Maximum Number of Iterations

nPop=N;           % Population Size
nEmp=3;            % Number of Empires/Imperialists

alpha=1;            % Selection Pressure

beta=2;             % Assimilation Coefficient

pRevolution=0.5;    % Revolution Probability
mu=0.1;             % Revolution Rate

zeta=0.1;           % Colonies Mean Cost Coefficient

%% Share (Globalize) Settings

global ProblemSettings;
ProblemSettings.CostFunction=CostFunction;
ProblemSettings.nVar=nVar;
ProblemSettings.VarSize=VarSize;
ProblemSettings.VarMin=VarMin;
ProblemSettings.VarMax=VarMax;

global ICASettings;
ICASettings.MaxIt=MaxIt;
ICASettings.nPop=nPop;
ICASettings.nEmp=nEmp;
ICASettings.alpha=alpha;
ICASettings.beta=beta;
ICASettings.pRevolution=pRevolution;
ICASettings.mu=mu;
ICASettings.zeta=zeta;

%% Initialization

% Initialize Empires
emp=CreateInitialEmpires();

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);
meancost = [];

%% ICA Main Loop

for it=1:MaxIt
    
    % Assimilation
    emp=AssimilateColonies(emp);
    
    % Revolution
    emp=DoRevolution(emp);
    
    % Intra-Empire Competition
    emp=IntraEmpireCompetition(emp);
    
    % Update Total Cost of Empires
    emp=UpdateTotalCost(emp);
    
    % Inter-Empire Competition
    emp=InterEmpireCompetition(emp);
    
    % Update Best Solution Ever Found
    imp=[emp.Imp];
    [~, BestImpIndex]=min([imp.Cost]);
    BestSol=imp(BestImpIndex);
    
    % Update Best Cost
    BestCost(it)=BestSol.Cost;
    meancost = [meancost mean([imp(:).Cost])];
    
    % Show Iteration Information
%     if BestSol.Sol.IsFeasible
%         Flag=' *';
%     else
%         Flag=[', DC = ' num2str(BestSol.Sol.q)];
%     end
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Plot Best Solution
%     figure(1);
%     PlotSolution(BestSol.Sol,model);
%     pause(0.01);
    
end

%% Results

% figure;
% plot(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');
