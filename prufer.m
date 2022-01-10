
% cost = prufer1([1 3 3 3 4]);
%���룺����������λ��
function cost = prufer(P)
    
    n = size(P,2)+2;%����λ�õ�ά��+2=�ڵ���-2+2=�ڵ���
    Q = [];
    for i = 1:n
        if find(P==i)%�������λ�����е��ڵ�ǰά�ȵģ�ʲôҲ����
            
        else%����ڵ�i����prufer���У�����뼯��Q
            Q = [Q i];
        end
    end
    
    i = 1;
    while ~isempty(P)%��prufer���ǿ�ʱ
       
        cost(i,1) = P(1);
        cost(i,2) = Q(1);
        
        Q = Q(2:end);%Qȥ����һ����
        ptemp = P(1);%�ݴ�prufer���еĵ�һ��
        P = P(2:end);%Pȥ����һ����
        if find(P==ptemp)%����ո��ݴ���Ǹ�����P�л�����֣�ʲôҲ����
            
        else%����ո��ݴ����������P�г�����
            Q = [ptemp Q];%�ͼ��뵽Q��
%             Q = sort(Q);%��Q��С��������
        end
        
        i = i+1;
    end
    cost(i,1) = Q(1);
    cost(i,2) = Q(2);
    
end