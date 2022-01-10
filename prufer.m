
% cost = prufer1([1 3 3 3 4]);
%输入：整数的粒子位置
function cost = prufer(P)
    
    n = size(P,2)+2;%粒子位置的维度+2=节点数-2+2=节点数
    Q = [];
    for i = 1:n
        if find(P==i)%如果粒子位置中有等于当前维度的，什么也不做
            
        else%如果节点i不在prufer数中，则加入集合Q
            Q = [Q i];
        end
    end
    
    i = 1;
    while ~isempty(P)%当prufer数非空时
       
        cost(i,1) = P(1);
        cost(i,2) = Q(1);
        
        Q = Q(2:end);%Q去掉第一个数
        ptemp = P(1);%暂存prufer数中的第一个
        P = P(2:end);%P去掉第一个数
        if find(P==ptemp)%如果刚刚暂存的那个数在P中还会出现，什么也不管
            
        else%如果刚刚暂存的数不会在P中出现了
            Q = [ptemp Q];%就加入到Q中
%             Q = sort(Q);%给Q从小到大排序
        end
        
        i = i+1;
    end
    cost(i,1) = Q(1);
    cost(i,2) = Q(2);
    
end