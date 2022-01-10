%% �Ӻ���
%��   �룺
%           pop              ��Ⱥ
%           VARIATIONRATE    ������
%��   ����
%           pop              ��������Ⱥ
%% 
function kidsPop = Variation(kidsPop,VARIATIONRATE,model)

for n=1:size(kidsPop,1)
    if rand<VARIATIONRATE
        temp = kidsPop(n,:);
        %�ҵ�����λ��
        location = ceil(length(temp)*rand);
        
        if location<=model.airship
            result = unidrnd(model.n*model.n);
            while any(temp==result)
                result = unidrnd(model.n*model.n);
            end
        else
            result = unidrnd(20);
            while any(temp==result)
                result = unidrnd(20);
            end
        end
        
        temp(location) = result;
        kidsPop(n,:) = temp;
    end
end