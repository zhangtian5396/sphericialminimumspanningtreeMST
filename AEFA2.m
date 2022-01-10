
function [bestsol,BestValues,MeanValues]=AEFA2(N,max_it,model)
%V:   �ٶ�.
%a:   ���ٶ�.
%Q:   ���  
%D:   ���Ժ�����ά��.
%N:   �������ӵ�����.
%X:   ���ӵ�λ��.
%R:   �����ռ��д�������֮��ľ���.
%lb:  ��������Сֵ
%ub:  ���������ֵ
%Rnorm: ŷ����÷���

FCheck=1; Rpower=1;
tag=1; % 1: minimization, 0: maximization
Rnorm=2;

fobj=@(xhat) MyCost_EOCAEFA(xhat,model);        % Cost Function

D=model.n-2;             % Number of Decision Variablesά���ǽڵ���-2
lb = 1;                  %�½�Ϊ1
ub = model.n;            %�Ͻ�Ϊ�ڵ���
%------------------------------------------------------------------------------------
%�����ʼ��������Ⱥ.
X=initialization(D,N,ub,lb);

%create the best so far chart and average fitnesses chart.
BestValues=[];MeanValues=[];

%��ʼ�������ٶ�
V=zeros(N,D);

 for i=1:N 
    %�������ӵĺ���ֵ
    [~,fitness(i),sol(i)]=fobj(X(i,:));
 end
 
%-------------------------------------------------------------------------------------
for iteration=1:max_it
    
%����ÿ�����ӵ���Ӧ��ֵ. 

    if tag==1
    [best, best_X]=min(fitness); %minimization.
    else
    [best, best_X]=max(fitness); %maximization.
    end        
    if iteration==1
       Fbest=best;Lbest=X(best_X,:);%ȫ�����ż���λ��
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
    
BestValues=[BestValues Fbest];%����ÿһ��������ֵ
bestsol = sol(best_X);%�������Ÿ������������Ϣ
MeanValues=[MeanValues mean(fitness)];%����ÿһ����Ŀ�꺯��ֵ��ƽ��ֵ
%-----------------------------------------------------------------------------------
% ��� 
Fmax=max(fitness); Fmin=min(fitness); Fmean=mean(fitness); 

if Fmax==Fmin
   Q=ones(N,1);
else
    
   if tag==1 %for minimization
      best=Fmin;worst=Fmax; 
      
   else %for maximization
       
      best=Fmax;worst=Fmin; 
   end
  
   Q=exp((fitness-worst)./(best-worst)); %����q
end

Q=Q./sum(Q); %����Q�����ӵĵ����
%----------------------------------------------------------------------------------

fper=3; %���������У�ֻ��2% - 6%�ĵ�ɶ��������ʩ����������

%----------------------------------------------------------------------------------
 %%%%ÿ�����ӵ��ܵ�������,����ÿ�������ܵ��������ӵĸ���
 if FCheck==1
     cbest=fper+(1-iteration/max_it)*(100-fper); 
     cbest=round(N*cbest/100);
 else
     cbest=N; 
 end
 [Qs s]=sort(Q,'descend');%��������
 for i=1:N
     E(i,:)=zeros(1,D);
     for ii=1:cbest
         j=s(ii);
         if j~=i
            R=norm(X(i,:)-X(j,:),Rnorm); %ŷʽ����
             for k=1:D 
                 E(i,k)=E(i,k)+ rand*(Q(j))*((X(j,k)-X(i,k))/(R^Rpower+eps));
             end
         end
     end
 end
%---------------------------------------------------------------------------------- 
%����ŷʽ����
%----------------------------------------------------------------------------------
alfa=30;
K0=500;
K=K0*exp(-alfa*iteration/max_it);%���׳���
%---------------------------------------------------------------------------------- 
%������ٶ�.
a=E*K; 
%----------------------------------------------------------------------------------
%����ƶ�
%----------------------------------------------------------------------------------
V=rand(N,D).*V+a;
X=X+V;
X=max(X,lb);X=min(X,ub);   % �������Ƿ񳬹��߽�

 for i=1:N 
    %�������ӵĺ���ֵ
    [~,fitness(i),sol(i)]=fobj(X(i,:));
 end
 
 
%  for i=1:N 
%     %�������ӵĺ���ֵ
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

if size(up,2)==1%���up����������1
    X=rand(N,dim).*(up-down)+down;%����Ⱥ����Ϊ30���ڵ���Ϊ25�����ʼ����ȺΪ30*23
end
if size(up,2)>1%���up����������1
    for i=1:dim
    high=up(i);low=down(i);
    X(:,i)=rand(N,1).*(high-low)+low;
    end
end
end