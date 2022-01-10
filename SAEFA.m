%% simplified AEFA algorithms
function [BestSol,BestCost,meanCost]=SAEFA(N,max_it,model)

BestCost = [];
meanCost = [];

objective=@(x) MyCost_EOCAEFA(x,model);    % Cost Function

D=model.n-2;      % Decision Variables Matrix Size

lb=1;          % Lower Bound of Decision Variables
ub=model.n;          % Upper Bound of Decision Variables

pop = N;               % Population size
var = D;                 % Number of design variables
maxGen = max_it;            % Maximum number of iterations
mini = lb.*ones(1,var);  % Lower Bound of Variables
maxi = ub.*ones(1,var);   % Upper Bound of Variables

 
%% initialize
[row,var] = size(mini);
x = zeros(pop,var);
fnew = zeros(pop,1);
% f = zeros(pop,1);
fopt= zeros(pop,1);
xopt=zeros(1,var);

V=zeros(N,D);

%%  Generation and Initialize the positions 
for i=1:var
    x(:,i) = mini(i)+(maxi(i)-mini(i))*rand(pop,1);
end

for i=1:pop
    [x(i,:),fitness(i),Sol(i)] = objective(x(i,:));
end

%%  Main Loop
gen=1;
while(gen <= maxGen)

    [row,col]=size(x);
    [t,tindex]=min(fitness);
    Best=x(tindex,:);
    [w,windex]=max(fitness);
    worst=x(windex,:);
    xnew=zeros(row,col);
    
    
    for i=1:row
        for j=1:col
                r = rand();
                
%                 radius = (1 - 1*(gen/maxGen));
                
                
                xnew(i,j) = r * (x(i,j)+rand* (Best(j)-(x(i,j)))) + (1-r) * (x(i,j)-rand* (worst(j)-(x(i,j))));
        end
    end
    
    for i=1:row
        xnew(i,:) = max(min(xnew(i,:),maxi),mini);   %越界处理
        [xnew(i,:),fnew(i,:),newsol(i)] = objective(xnew(i,:));
    end
    
    for i=1:pop
        if(fnew(i)<fitness(i))
            x(i,:) = xnew(i,:);
            Sol(i) = newsol(i);
            fitness(i) = fnew(i);
        end
    end

    fnew = []; xnew = [];
    [fopt(gen),ind] = min(fitness);
    BestSol= Sol(ind);
    gen = gen+1;  
%     disp(['Iteration No. = ',num2str(gen), ',   Best Cost = ',num2str(min(fitness))])
    BestCost = [BestCost min(fitness)];
    meanCost = [meanCost mean(fitness)];
    
end
disp(['Iteration No. = ',num2str(gen), ',   Best Cost = ',num2str(min(fitness))]);
end