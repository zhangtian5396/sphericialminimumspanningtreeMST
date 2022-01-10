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
%���룺��ǰ���ӵ�λ�ã�ȫ���ڵ�λ��
%���������λ�ã�Ŀ�꺯��ֵ�����������ۣ����������������Ϣ
function [xhat,z, sol]=MyCost_EOCAEFA(xhat,model)
    
    D.AV = [1:model.n];%��1���ڵ�����һ������
    for kkk = 1:size(xhat,2)%size(xhat,2)��xhat�����������ڵ���-2
        aa = find(D.AV >= xhat(1,kkk),1,'first');%������D.AV >= xhat(1,kkk)��Ӧ�ĵ�һ������
        bb = find(D.AV <= xhat(1,kkk),1,'last');%������D.AV <= xhat(1,kkk)��Ӧ�����һ������
        %�����������еĵ�kkk������aa��bb�м�
        if abs(D.AV(aa)-xhat(1,kkk)) < abs(D.AV(bb)-xhat(1,kkk))%��kkk�����������ĸ������ͱ���ĸ�����
            xhat(1,kkk) = D.AV(aa);
        else
            xhat(1,kkk) = D.AV(bb);
        end
    end

    cost = prufer(xhat);%��ǰ�������ӷ���
    A = zeros(model.n);%n*n��0
    for i = 1:model.n-1%costһ���ڵ���-1�У����ܹ����������������ڵ����1
            A(cost(i,1),cost(i,2)) = 1;
            A(cost(i,2),cost(i,1)) = 1;
    end
    
    d=model.d;%�����ڵ��ľ���

    AD=A.*d;%�������*0-1����=ʵ����ÿ�������ӵĽڵ��ľ���
   
    SumAD=sum(AD(:))/2;%���ӵĽڵ�ľ���֮�ͣ����������Ĵ���
    
    z=SumAD;%�������Ĵ���
    sol.A=A;%0-1����
    sol.SumAD=SumAD;%�������Ĵ���;
    sol.z=z;%�������Ĵ���
    sol.cost = cost;%�������Ľڵ����ӷ���

end