
function [Lbest,BestValues,MeanValues]=AEFA(N,max_it,model)
%V:   速度.
%a:   加速度.
%Q:   电荷  
%D:   测试函数的维数.
%N:   带电粒子的数量.
%X:   粒子的位置.
%R:   搜索空间中带电粒子之间的距离.
%lb:  变量的最小值
%ub:  变量的最大值
%Rnorm: 欧几里得范数

FCheck=1; Rpower=1;
tag=1; % 1: minimization, 0: maximization
Rnorm=2;

fobj=@(xhat) MyCost(xhat,model);        % Cost Function

D=model.n*(model.n-1)/2;             % Number of Decision Variables
lb = 0;
ub = 1;
%------------------------------------------------------------------------------------
%随机初始化粒子种群.
X=initialization(D,N,ub,lb);

%create the best so far chart and average fitnesses chart.
BestValues=[];MeanValues=[];

%初始化粒子速度
V=zeros(N,D);

 for i=1:N 
    %计算粒子的函数值
    fitness(i)=fobj(X(i,:));
 end
 
%-------------------------------------------------------------------------------------
for iteration=1:max_it
    
%评价每个粒子的适应度值. 

 
 %fitness =benchmark(X,func_num,D);
 
    if tag==1
    [best, best_X]=min(fitness); %minimization.
    else
    [best, best_X]=max(fitness); %maximization.
    end        
    if iteration==1
       Fbest=best;Lbest=X(best_X,:);
    end
    if tag==1
      if best<Fbest  %minimization.
       Fbest=best;Lbest=X(best_X,:);
      end
    else 
      if best>Fbest  %maximization
       Fbest=best;Lbest=X(best_X,:);
      end
    end
    
BestValues=[BestValues Fbest];
MeanValues=[MeanValues mean(fitness)];
%-----------------------------------------------------------------------------------
% 电荷 
Fmax=max(fitness); Fmin=min(fitness); Fmean=mean(fitness); 

if Fmax==Fmin
   Q=ones(N,1);
else
    
   if tag==1 %for minimization
      best=Fmin;worst=Fmax; 
      
   else %for maximization
       
      best=Fmax;worst=Fmin; 
   end
  
   Q=exp((fitness-worst)./(best-worst)); 
end

Q=Q./sum(Q); 
%----------------------------------------------------------------------------------

fper=3; %在最后迭代中，只有2% - 6%的电荷对其他电荷施加作用力。

%----------------------------------------------------------------------------------
 %%%%每个电子的总电力计算,计算每个粒子受到其他粒子的个数
 if FCheck==1
     cbest=fper+(1-iteration/max_it)*(100-fper); 
     cbest=round(N*cbest/100);
 else
     cbest=N; 
 end
 [Qs s]=sort(Q,'descend');%降序排列
 for i=1:N
     E(i,:)=zeros(1,D);
     for ii=1:cbest
         j=s(ii);
         if j~=i
            R=norm(X(i,:)-X(j,:),Rnorm); %欧式距离
             for k=1:D 
                 E(i,k)=E(i,k)+ rand*(Q(j))*((X(j,k)-X(i,k))/(R^Rpower+eps));
             end
         end
     end
 end
%---------------------------------------------------------------------------------- 
%计算欧式距离
%----------------------------------------------------------------------------------
alfa=30;
K0=500;
K=K0*exp(-alfa*iteration/max_it);
%---------------------------------------------------------------------------------- 
%计算加速度.
a=E*K; 
%----------------------------------------------------------------------------------
%电荷移动
%----------------------------------------------------------------------------------
V=rand(N,D).*V+a;
X=X+V;
X=max(X,lb);X=min(X,ub);   % 检测变量是否超过边界

 for i=1:N 
    %计算粒子的函数值
    fitness(i)=fobj(X(i,:));
 end
%  for i=1:N 
%     %计算粒子的函数值
%     fnew(i)=fobj(newX(i,:));
%  end
% 
%     for i=1:N
%         if(fnew(i)<fitness(i))
%             X(i,:) = newX(i,:);
%             fitness(i) = fnew(i);
%         end
%     end

%----------------------------------------------------------------------------------
% disp(['Iteration ' num2str(iteration) ': BestValues = ' num2str(BestValues(end)) ' : MeanValues = ' num2str(MeanValues(end))]);
end
% disp(['Iteration ' num2str(iteration) ': BestValues = ' num2str(BestValues(end)) ' : MeanValues = ' num2str(MeanValues(end))]);
end


% This function initialize the first population of search agents
function X=initialization(dim,N,up,down)

if size(up,2)==1
    X=rand(N,dim).*(up-down)+down;
end
if size(up,2)>1
    for i=1:dim
    high=up(i);low=down(i);
    X(:,i)=rand(N,1).*(high-low)+low;
    end
end
end