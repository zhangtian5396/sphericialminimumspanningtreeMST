
clear all;
clc;

for i=1:1
    num=1;
    for j = 1:num
        model = loadmodel(i);%��ȡ�������� 
        city_n=model.n;
        rng('default');%�� rand��randi �� randn ʹ�õ����������������������Ϊ��Ĭ��ֵ����������������ͬ����������ͺ��������������� MATLAB��Ĭ������������Ϊ 0 ��÷ɭ��ת��������
        rng(1);
        max_it=300;
        rand('seed', sum(100*clock));
        N=30;
        
       disp(['F' num2str(i) '_t=' num2str(j)]);
%          %�Ľ��糡�㷨
%         [EOCAEFAsol,EOCAEFAbest,EOCAEFAmeanbest]=EOCAEFA(N,max_it,model);
%         EOCAEFABEST(j) = EOCAEFAbest(end);
        %�Ľ������㷨
        tic;
        [IMAsol,IMAbest]=MA_BB(N,max_it,model);
        IMABEST(j) = IMAbest(end);
        T_IMA(j)=toc;

%         tic;
%         [DEsol,DEbest]=DE(N,max_it,model);
%         DEBEST(j)=DEbest(end);
%         T_DE(j)=toc;
%         
%          tic;
%         [AMOsol,AMObest]=AMO(N,max_it,model);
%         AMOBEST(j)=AMObest(end);
%         T_AMO(j)=toc;
%         tic;
%         [MPAsol,MPAbest]=MPA(N,max_it,model);
%         MPABEST(j) = MPAbest(end);
%         T_MPA(j)=toc;
        %�����㷨
%         tic;
%         [MAsol,MAbest]=MA(N,max_it,model);
%         MABEST(j) = MAbest(end); 
%         T_MA(j)=toc;
%        
%         %�糡�㷨
%         tic;
%         [AEFAsol,AEFAbest,AEFAmeanbest]=AEFA2(N,max_it,model);
%         AEFABEST(j) = AEFAbest(end);  
%         T_AEFA(j)=toc;
%         
%         %����Ⱥ�㷨
%         tic;
%         [PSOsol,PSObest,PSOmeanbest]=pso(N,max_it,model);
%         PSOBEST(j) = PSObest(end);
%         T_PSO(j)=toc;
%         
%         %�۹����徺���㷨
%         tic;
%         [ICAsol,ICAbest,ICAmeanbest]=ica(N,max_it,model);
%         ICABEST(j) = ICAbest(end);
%         T_ICA(j)=toc;
%         
%         %ө����㷨
%         tic;
%         [FAsol,FAbest,FAmeanbest]=fa(N,max_it,model);
%         FABEST(j) = FAbest(end);
%         T_FA(j)=toc;
%         
%         %�Ŵ��㷨
%         tic;
%         [GAsol,GAbest,GAmeanbest]=GA(N,max_it,model);
%         GABEST(j) = GAbest(end);
%         T_GA(j)=toc;
%         
%         % �ȳ��Ż��㷨
%         tic;
%         [GOAsol,GOAbest]=GOA(N,max_it,model);
%         GOABEST(j) = GOAbest(end);
%         T_GOA(j)=toc;
%         
%          % �����Ż��㷨
%          tic;
%         [GWOsol,GWObest]=GWO(N,max_it,model);
%         GWOBEST(j) = GWObest(end);
%         T_GWO(j)=toc;
%         
%          %��Ÿ�Ż��㷨
%          tic;
%         [SOAsol,SOAbest]=SOA(N,max_it,model);
%         SOABEST(j) = SOAbest(end);
%         T_SOA(j)=toc;
%         
%          %���Ż��㷨
%          tic;
%         [SMAsol,SMAbest]=SMA(N,max_it,model);
%         SMABEST(j) = SMAbest(end);
%         T_SMA(j)=toc;
     
%         figure;
%         semilogy(IMAbest,'k','LineWidth',2);hold on;
%         semilogy(MAbest,'b','LineWidth',1.5);hold on;  
%         semilogy(AEFAbest,'m','LineWidth',1.5);hold on;      
%         semilogy(PSObest,'y','LineWidth',1.5);hold on;
%         semilogy(ICAbest,'g','LineWidth',1.5);hold on;
%         semilogy(FAbest,'c','LineWidth',1.5);hold on;
%         semilogy(GAbest,'r','LineWidth',1.5);hold on;
%         semilogy(GOAbest,'--k','LineWidth',1.5);hold on;
%         semilogy(GWObest,'--b','LineWidth',1.5);hold on;
%         semilogy(SOAbest,':r','LineWidth',1.5);hold on;
%         semilogy(SMAbest,'-.c','LineWidth',1.5); hold on;
%         semilogy(MPAbest,'r','LineWidth',1.5);hold on;  
%         legend('BBMA','MA')
%         legend('BBMA','MA','AEFA','PSO','ICA','FA','GA','GOA','GWO','SOA','SMA');
%         xlabel('\fontsize{12}\bf Iterations'); ylabel('\fontsize{12}\bf Fitness Value');
%         title('\fontsize{12}\bf The convergence curves of algorithms for 1000 points');
%         grid on;

    end

     B_IMABEST=min(IMABEST); W_IMABEST=max(IMABEST); M_IMABEST=mean(IMABEST);STD_IMABEST=std(IMABEST);tBBMA=mean(T_IMA);
%      B_MABEST=min(MABEST);W_MABEST=max(MABEST); M_MABEST=mean(MABEST);STD_MABEST=std(MABEST);tMA=mean(T_MA);
%      B_AEFABEST=min(AEFABEST);W_AEFABEST=max(AEFABEST); M_AEFABEST=mean(AEFABEST);STD_AEFABEST=std(AEFABEST);tAEFA=mean(T_AEFA);
%      B_PSOBEST=min(PSOBEST);W_PSOBEST=max(PSOBEST); M_PSOBEST=mean(PSOBEST);STD_PSOBEST=std(PSOBEST);tPSO=mean(T_PSO);
%      B_ICABEST=min(ICABEST);W_ICABEST=max(ICABEST); M_ICABEST=mean(ICABEST);STD_ICABEST=std(ICABEST);tICA=mean(T_ICA);
%      B_FABEST=min(FABEST);W_FABEST=max(FABEST); M_FABEST=mean(FABEST);STD_FABEST=std(FABEST);tFA=mean(T_FA);
%      B_GABEST=min(GABEST);W_GABEST=max(GABEST); M_GABEST=mean(GABEST);STD_GABEST=std(GABEST);tGA=mean(T_GA);
%      B_GOABEST=min(GOABEST);W_GOABEST=max(GOABEST); M_GOABEST=mean(GOABEST);STD_GOABEST=std(GOABEST);tGOA=mean(T_GOA);
%      B_GWOBEST=min(GWOBEST);W_GWOBEST=max(GWOBEST); M_GWOBEST=mean(GWOBEST);STD_GWOBEST=std(GWOBEST);tGWO=mean(T_GWO);
%      B_SOABEST=min(SOABEST);W_SOABEST=max(SOABEST); M_SOABEST=mean(SOABEST);STD_SOABEST=std(SOABEST);tSOA=mean(T_SOA);
%      B_SMABEST=min(SMABEST);W_SMABEST=max(SMABEST); M_SMABEST=mean(SMABEST);STD_SMABEST=std(SMABEST);tSMA=mean(T_SMA);
%      B_MPABEST=min(MPABEST);W_MPABEST=max(MPABEST); M_MPABEST=mean(MPABEST);STD_MPABEST=std(MPABEST);tMPA=mean(T_MPA);
%      B_DEBEST=min(DEBEST);W_DEBEST=max(DEBEST); M_DEBEST=mean(DEBEST);STD_DEBEST=std(DEBEST);tDE=mean(T_DE);
%      B_AMOBEST=min(AMOBEST);W_AMOBEST=max(AMOBEST); M_AMOBEST=mean(AMOBEST);STD_AMOBEST=std(AMOBEST);tAMO=mean(T_AMO);


    disp(['IMA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_IMABEST) '  �����Ϊ��' num2str(W_IMABEST) '  ƽ�����Ϊ��' num2str(M_IMABEST) '  ��׼��Ϊ��' num2str(STD_IMABEST)]); 
%     disp(['MA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_MABEST) '  �����Ϊ��' num2str(W_MABEST) '  ƽ�����Ϊ��' num2str(M_MABEST) '  ��׼��Ϊ��' num2str(STD_MABEST)]);
%     disp(['AEFA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_AEFABEST) '  �����Ϊ��' num2str(W_AEFABEST) '  ƽ�����Ϊ��' num2str(M_AEFABEST) '  ��׼��Ϊ��' num2str(STD_AEFABEST)]);
%     disp(['PSO����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_PSOBEST) '  �����Ϊ��' num2str(W_PSOBEST) '  ƽ�����Ϊ��' num2str(M_PSOBEST) '  ��׼��Ϊ��' num2str(STD_PSOBEST)]); 
%     disp(['ICA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_ICABEST) '  �����Ϊ��' num2str(W_ICABEST) '  ƽ�����Ϊ��' num2str(M_ICABEST) '  ��׼��Ϊ��' num2str(STD_ICABEST)]); 
%     disp(['FA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_FABEST) '  �����Ϊ��' num2str(W_FABEST) '  ƽ�����Ϊ��' num2str(M_FABEST) '  ��׼��Ϊ��' num2str(STD_FABEST)]); 
%     disp(['GA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_GABEST) '  �����Ϊ��' num2str(W_GABEST) '  ƽ�����Ϊ��' num2str(M_GABEST) '  ��׼��Ϊ��' num2str(STD_GABEST)]);       
%     disp(['GOA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_GOABEST) '  �����Ϊ��' num2str(W_GOABEST) '  ƽ�����Ϊ��' num2str(M_GOABEST) '  ��׼��Ϊ��' num2str(STD_GOABEST)]); 
%     disp(['GWO����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_GWOBEST) '  �����Ϊ��' num2str(W_GWOBEST) '  ƽ�����Ϊ��' num2str(M_GWOBEST) '  ��׼��Ϊ��' num2str(STD_GWOBEST)]); 
%     disp(['SOA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_SOABEST) '  �����Ϊ��' num2str(W_SOABEST) '  ƽ�����Ϊ��' num2str(M_SOABEST) '  ��׼��Ϊ��' num2str(STD_SOABEST)]); 
%     disp(['SMA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_SMABEST) '  �����Ϊ��' num2str(W_SMABEST) '  ƽ�����Ϊ��' num2str(M_SMABEST) '  ��׼��Ϊ��' num2str(STD_SMABEST)]); 
%     disp(['MPA����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_MPABEST) '  �����Ϊ��' num2str(W_MPABEST) '  ƽ�����Ϊ��' num2str(M_MPABEST) '  ��׼��Ϊ��' num2str(STD_MPABEST)]);
%     disp(['DE����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_DEBEST) '  �����Ϊ��' num2str(W_DEBEST) '  ƽ�����Ϊ��' num2str(M_DEBEST) '  ��׼��Ϊ��' num2str(STD_DEBEST)]);
%     disp(['AMO����' num2str(num) '�ε���ý��Ϊ�� ' num2str(B_AMOBEST) '  �����Ϊ��' num2str(W_AMOBEST) '  ƽ�����Ϊ��' num2str(M_AMOBEST) '  ��׼��Ϊ��' num2str(STD_AMOBEST)]);

end