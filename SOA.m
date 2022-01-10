
%%% Designed and Developed by Dr. Gaurav Dhiman (http://dhimangaurav.com/) %%%


function[BestSol,Convergence]=SOA(Search_Agents,Max_iterations,model)
objective=@(xhat) MyCost_EOCAEFA(xhat,model);
dimension=model.n-2;%维度=节点数-2
Lower_bound = 1;                  %下界为1
Upper_bound = model.n;            %上界为节点数
Position=zeros(1,dimension);
Score=inf; 

Positions=inital(Search_Agents,dimension,Upper_bound,Lower_bound);

Convergence=zeros(1,Max_iterations);

l=0;

while l<Max_iterations
    for i=1:size(Positions,1)  
        
        Flag4Upper_bound=Positions(i,:)>Upper_bound;
        Flag4Lower_bound=Positions(i,:)<Lower_bound;
        Positions(i,:)=(Positions(i,:).*(~(Flag4Upper_bound+Flag4Lower_bound)))+Upper_bound.*Flag4Upper_bound+Lower_bound.*Flag4Lower_bound;               
        
        [Positions(i,:),fitness,Sol]=objective(Positions(i,:));
        
        if fitness<Score 
            Score=fitness; 
            BestSol=Sol;
            Position=Positions(i,:);
        end
        

    end
    
    
    Fc=2-l*((2)/Max_iterations); 
    
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
                       
            r1=rand(); 
            r2=rand(); 
            
            A1=2*Fc*r1-Fc; 
            C1=2*r2; 
            b=1;             
            ll=(Fc-1)*rand()+1;  
       
            D_alphs=Fc*Positions(i,j)+A1*((Position(j)-Positions(i,j)));                   
            X1=D_alphs*exp(b.*ll).*cos(ll.*2*pi)+Position(j);
            Positions(i,j)=X1;
            
        end
    end
    l=l+1;    
    Convergence(l)=Score;
%     disp(['Iteration ' num2str(l) ': BestValues = ' num2str(Convergence(l))]);
end



