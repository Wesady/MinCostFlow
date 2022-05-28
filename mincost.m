function [G,fee] = mincost(G1,G2,vs,vt,pl)%G1权重为网络的容量，G2的权重为网络的单位运费,vs为发点，vt为收点


%必要的复制
G = G1;
G3 = G1;
G4 = G2;

%求最大流
v = maxflow(G1,vs,vt);

%初始化当前流
flow = 0;



%迭代求解
while flow ~= v
    %求最小费用通路
    [miu,~] = shortestpath(G2,vs,vt,'Method','mixed');
    
    
    %分配最大可能的流量
    fl = inf;       
    for i = 1:length(miu) - 1%遍历最短路径的每条边
        if searchG(G1,miu{i},miu{i + 1}) < fl
        	fl = searchG(G1,miu{i},miu{i + 1});
        end
    end
    
    %如果当前流超出目标流
    if flow + fl > v
        fl = v - flow;
    end
    
   
    for i = 1:length(miu) - 1%遍历最短路径的每条边
        %减少通路上边的容量
        cij = searchG(G1,miu{i},miu{i + 1});
        G1 = rmedge(G1,miu{i},miu{i + 1});
        G1 = addedge(G1,miu{i},miu{i + 1},cij - fl);
        %修改饱和边的单位流费用
        if cij - fl == 0            
            G2 = rmedge(G2,miu{i},miu{i + 1});
        end
    end
    
    
    %作反向边
    for i = 1:length(miu) - 1%遍历最短路径的每条边
        
        %cji
        cji = searchG(G1,miu{i + 1},miu{i});               
        if ~isnan(cji)
            G1 = rmedge(G1,miu{i + 1},miu{i});
            G1 = addedge(G1,miu{i + 1},miu{i},cji + fl);
        else
            G1 = addedge(G1,miu{i + 1},miu{i},fl);
        end        
        
        %bji
        if ~isnan(searchG(G2,miu{i + 1},miu{i}))
            G2 = rmedge(G2,miu{i + 1},miu{i});
        end
        bij = searchG(G4,miu{i},miu{i + 1});
        if isnan(bij)
            G2 = addedge(G2,miu{i + 1},miu{i},searchG(G4,miu{i + 1},miu{i}));
        else
            G2 = addedge(G2,miu{i + 1},miu{i},-bij);
        end
        
    end
    
    
    %全部流量
    flow = flow + fl;
end



%计算费用并生成方案图
fee = 0;
for i = 1:height(G3.Edges)%查找边的容量
    G1ee = searchG(G1,G3.Edges.EndNodes{i,1},G3.Edges.EndNodes{i,2});
    G4ee = searchG(G4,G3.Edges.EndNodes{i,1},G3.Edges.EndNodes{i,2});
    G3ee = searchG(G3,G3.Edges.EndNodes{i,1},G3.Edges.EndNodes{i,2});
    G = rmedge(G,G3.Edges.EndNodes{i,1},G3.Edges.EndNodes{i,2});
    G = addedge(G,G3.Edges.EndNodes{i,1},G3.Edges.EndNodes{i,2},G3ee - G1ee);
    fee = fee + (G3ee - G1ee)*G4ee;
end


%可视化最大流图
if pl == 1
    plot(G,'EdgeLabel',G.Edges.Weight);
end


end